class CheckinsController < ApplicationController
  def create
    person = Person.find(checkin_params[:person_id])
    @checkin = CreateCheckin.call(person, Event.last, checkin_params[:weight].to_f, current_user)
    redirect_to people_path
  rescue
    flash[:error] = "Please fill out all fields"
    redirect_to new_checkin_path
  end

  def new
    @people = Person.all.order(:name)
  end

  private
  def checkin_params
    params.require(:checkin).permit(:weight, :person_id)
  end
end