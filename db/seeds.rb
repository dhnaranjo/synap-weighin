require 'csv'

participants_csv = CSV.foreach(Rails.root.join('lib/seeds/participants.csv'), headers: true)

date_sorted_participants = participants_csv
  .to_a
  .sort_by { |row| Date.parse(row['Date']) }

people = date_sorted_participants.uniq { |row| row['Name'] }
Person.transaction do
  people.each do |person|
    Person.create(
      name: person['Name'],
      created_at: person['Date'],
      league: League.find_or_initialize_by(
        name: person['League'],
        created_at: person['Date']
      )
    )
  end
end

events = date_sorted_participants.uniq { |event| event['Event'] }
Event.transaction do
  events.each do |event|
    Event.create(name: event['Event'], created_at: event['Date'])
  end
end

checkins_csv = CSV.foreach(Rails.root.join('lib/seeds/weighins.csv'), headers: true)

time_sorted_checkins = checkins_csv
  .to_a
  .sort_by { |row| Date.parse(row['Time']) }

Checkin.transaction do
  time_sorted_checkins.each do |checkin|
    CreateCheckin.call(
      Person.find_by(name: checkin['Name']),
      Event.find_by('DATE(created_at) = ?', Date.parse(checkin['Time'])),
      checkin['Weight'].to_f,
      nil
    )
  end
end
