require 'spec_helper'

describe User do
  describe '#people' do
    let(:user) { User.create(email: 'tester@murphyweighin.com', password: 'eat2compete') }
    let(:person) { Person.create }
    it 'has people' do
      user.user_person_joins.create(person: person)
      expect(user.people).to match_array([person])
    end
  end
end
