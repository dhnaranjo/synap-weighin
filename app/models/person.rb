class Person < ActiveRecord::Base

  belongs_to :league
  has_many :checkins
  has_many :user_person_joins
  has_many :users, through: :user_person_joins

  def self.ordered_by_up_by(people, event = nil)
    people
      .sort_by { |person| [-(person.up_by(event)), person.name, person.id] }
  end

  def up_by(event = nil)
    return attributes['up_by'] if event.nil?
    @up_by_event ||= {}
    return @up_by_event[event] if @up_by_event.has_key?(event)
    @up_by_event[event] =
      begin
        if checkins.loaded?
          checkins_from_event = checkins.select { |checkin| checkin.event == event }
        else
          checkins_from_event = checkins.where(event: event).order(:created_at)
        end
        return 0 if checkins_from_event.first.nil?
        first_checkin = checkins_from_event.first
        last_checkin = checkins_from_event.last
        last_checkin.weight - first_checkin.weight
      end
  end

  def percentage_change(event = nil)
    return 0 unless up_by
    @percentage_change ||= starting_weight ?  up_by(event).to_f / starting_weight * 100 : nil
  end

  def checkin_diffs
    grouped = checkins.includes(:event).order('events.created_at').group_by(&:event)
    event_diffs = {}
    grouped.each_pair do |event, event_checkins|
      diffs = event_checkins.sort_by(&:created_at).map(&:delta).compact
      event_diffs[event.try(:name)] = diffs.map { |d| '%.2f' % d }
    end
    event_diffs
  end
end
