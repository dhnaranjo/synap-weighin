namespace :seeds do
  desc "Create test data for performance checking"
  task create: :environment do
    people = FactoryBot.create_list(:person, 100)
    FactoryBot.create_list(:event, 10, :with_many_checkins, people: people, checkin_count: 10)
  end
end
