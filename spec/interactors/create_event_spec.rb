require 'spec_helper'

describe CreateEvent do
  let!(:person) { Person.create(starting_weight: 100, up_by: 10) }
  let!(:event) { Event.create(name: '1')}
  let(:tagline) { 'The Secret of the Ooze' }

  subject { described_class.call('2', tagline) }

  it 'creates a new event' do
    expect{subject}.to change{Event.count}.by(1)
  end

  it 'blanks starting_weight and up_by' do
    subject
    person.reload
    expect(person.starting_weight).to be(nil)
    expect(person.up_by).to be(nil)
  end

  it 'sets the name and tagline' do
    expect(subject.name).to eql('2')
    expect(subject.tagline).to eql(tagline)
  end
end
