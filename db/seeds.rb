require 'csv'

participants_csv = CSV
  .foreach(Rails.root.join('lib/seeds/participants.csv'), headers: true)
  .to_a

leagues = participants_csv.uniq { |row| row['League'] }.map do |league|
  League.new(
    name: league['League'],
    created_at: league['Date']
  )
end

people = participants_csv.uniq { |row| row['Name'] }.map do |person|
  Person.new(
    name: person['Name'],
    created_at: person['Date'],
    league: leagues.select { |league| league.name == person['League'] }.first
  )
end

events = participants_csv.uniq { |row| row['Event'] }.map do |event|
  Event.new(
    name: event['Event'],
    created_at: event['Date']
  )
end

Person.transaction do
  leagues.each(&:save!)
  people.each(&:save!)
  events.each(&:save!)
end

checkins = CSV.foreach(Rails.root.join('lib/seeds/weighins.csv'), headers: true)
  .to_a
  .sort_by { |row| [DateTime.parse(row['Time']), row['Name']] }
  .each do |checkin|
    CreateCheckin.call(
      # Person.find_by(name: checkin['Name']),
      people.select { |person| person.name == checkin['Name'] }.first,
      events.select { |event| event.created_at.to_date == Date.parse(checkin['Time']) }.first,
      # Event.find_by('DATE(created_at) = ?', Date.parse(checkin['Time'])),
      checkin['Weight'].to_f,
      nil
    )
end
