class EventsController < ApplicationController
  def index
    @events = Event.all.order(:id)
  end

  def show
    @event = Event.includes(:leagues, :people).find(params[:id])
    @current_event = true if @event == Event.last
  end

  def create
    @event = Event.create(event_params)
    redirect_to people_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :tagline)
  end
end
