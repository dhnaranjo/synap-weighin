require 'csv'

participants_csv = CSV.foreach(Rails.root.join('lib/seeds/participants.csv'), headers: true)

date_sorted_participants = participants_csv
  .to_a
  .sort_by { |row| Date.parse(row['Date']) }

persons = date_sorted_participants.uniq { |row| row['Name'] }
Person.transaction do
  persons.each do |person|
    Person.create(
      name: person['Name'],
      created_at: person['Date'],
      league: League.find_or_initialize_by(name: person['League'])
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

Checkin.transaction do
  checkins_csv.each do |checkin|
    Checkin.create(
      person: Person.find_by(name: checkin['Name']),
      event: Event.find_by('DATE(created_at) = ?', Date.parse(checkin['Time'])),
      weight: checkin['Weight'],
      created_at: checkin['Time']
    )
  end
end

Person.transaction do
  Person.all.each do |person|
    checkins = person.checkins.order(:created_at)
    first_checkin = checkins.first
    person.update(starting_weight: first_checkin.weight)
    checkins.reduce(first_checkin.weight) do |prev_weight, checkin|
      checkin.update(delta: checkin.weight - first_checkin.weight)
    end
  end
end
