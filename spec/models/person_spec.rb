require 'spec_helper'

describe Person do
  let(:person) { Person.create }
  let(:e1) { Event.create(name: '1', created_at: 1.year.ago)}
  let(:user) { User.create(email: 'tester@murphyweighin.com', password: 'eat2compete') }
  let(:c1) { CreateCheckin.call(person, e1, 100, user)}
  let(:c2) { CreateCheckin.call(person, e1, 200, user)}
  let(:c3) { CreateCheckin.call(person, e1, 250, user)}

  let(:e2) { Event.create(name: '2', created_at: 1.day.ago)}
  let(:c4) { CreateCheckin.call(person, e2, 101, user)}
  let(:c5) { CreateCheckin.call(person, e2, 202, user)}
  let(:c6) { CreateCheckin.call(person, e2, 303, user)}

  describe '#up_by' do
    subject { person.up_by }
    context 'with no event specified' do
      context 'with 0 checkins' do
        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
      context 'with one checkin' do
        before { c1 }
        it 'returns 0' do
          expect(subject).to be_nil
        end
      end
      context 'with two checkins' do
        before { c1; c2 }
        it 'calculates the difference between first and last Checkin' do
          expect(subject).to eql(100)
        end
      end
      context 'with many checkins' do
        before { c1; c2; c3}
        it 'calculates the difference between first and last Checkin' do
          expect(subject).to eql(150)
        end
      end
      context 'with many events' do
        before { c4; c5; c6 }
        it 'only uses the checkins from the last event' do
          expect(subject).to eql(202)
        end
      end
    end
    context 'with an event specified' do
      before { c4; c5; c6 }
      subject { person.up_by(e1) }

      context 'with 0 checkins' do
        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
      context 'with one checkin' do
        before { c1 }
        it 'returns 0' do
          expect(subject).to be_nil
        end
      end
      context 'with two checkins' do
        before { c1; c2 }
        it 'calculates the difference between first and last Checkin' do
          expect(subject).to eql(100)
        end
      end
      context 'with many checkins' do
        before { c1; c2; c3}
        it 'calculates the difference between first and last Checkin' do
          expect(subject).to eql(150)
        end
      end
    end
  end
  describe '#percentage_change' do
    subject { person.percentage_change }
    context 'with 0 checkins' do
      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
    context 'with one checkin' do
      before { c1 }
      it 'returns 0' do
        expect(subject).to be_nil
      end
    end
    context 'with two checkins' do
      before { c1; c2 }
      it 'calculates the difference between first and last Checkin' do
        expect(subject.to_f).to eq(100.0)
      end
    end
    context 'with many checkins' do
      before { c1; c2; c3}
      it 'calculates the difference between first and last Checkin' do
        expect(subject.to_f).to eq(150.0)
      end
    end
    context 'with many events' do
      before { c4; c5; c6 }
      it 'only uses the checkins from the last event' do
        expect(subject.to_f).to eql(200.0)
      end
    end
  end
  describe '#checkin_diffs' do
    subject { person.checkin_diffs }
    context 'with one event' do
      before {c1; c2; c3}
      it 'gives the difference between checkins, in order' do
        expect(subject).to eql({"1" => ['100.00','150.00']})
      end
    end
    context 'with many events' do
      before { c4; c5; c6; c1; c2; c3; }
      it 'maps the events to the checkins' do
        expect(subject).to eql({"1" => ['100.00','150.00'], "2" => ['101.00', '202.00']})
      end
    end
  end
end
