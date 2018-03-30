class LeaguesController < ApplicationController
  def index
    @leagues = League.all.order(:id)
  end

  def show
    @league = League.find(params[:id])
  end

  def create
    @league = League.create(league_params)
    redirect_to people_path
  end

  private

  def league_params
    params.require(:league).permit(:name, :tagline)
  end
end
