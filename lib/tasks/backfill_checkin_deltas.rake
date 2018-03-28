namespace :checkins do
  desc "Backfill deltas on weights"
  task backfill_deltas: :environment do
    Checkin.find_each do |c|
      previous_checkin = Checkin.where(person: c.person, event: c.event).where('created_at < ?', c.created_at).last
      if previous_checkin
        delta = c.weight - previous_checkin.weight
        c.delta = delta
        c.save
      end
    end
  end
end
