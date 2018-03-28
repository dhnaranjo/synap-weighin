FactoryBot.define do
  factory :event do
    name { "#{Faker::Name.last_name} Family #{Faker::Food.dish} Competition" }
    tagline { Faker::Company.bs }

    trait :with_initial_checkins do
      transient do
        people { create_list(:person, 5) }
      end

      after :create do |event, evaluator|
        people.each do |person|
          CreateCheckin.call(person, event, 100, nil)
          create(:checkin, person: person)
        end
      end
    end

    trait :with_many_checkins do
      transient do
        person_count 5
        checkin_count 5
        people { create_list(:person, person_count) }
      end

      after :create do |event, evaluator|
        evaluator.people.each do |person|
          evaluator.checkin_count.times { |i| CreateCheckin.call(person, event, 100 + i, nil) }
        end
      end
    end
  end
end
