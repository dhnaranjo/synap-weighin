class PeopleController < ApplicationController
  def create
    @person = Person.create(
      name: person_params[:name],
      league: League.find(person_params[:league_id])
    )
    CreateCheckin.call(@person, Event.last, checkin_params[:weight].to_f, current_user)
    redirect_to people_path
  end

  def index
    @event = Event.last
    if @event
      redirect_to event_path(@event)
    else
      redirect_to new_event_path
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  private
  def person_params
    params.required(:person).permit([:name, :league_id])
  end

  def checkin_params
    params.required(:person).permit([:weight])
  end
end
