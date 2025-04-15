class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @competitions = Competition
    .joins(:events)
    .where("events.commence_time > ?", Time.now)
    .group("competitions.id, competitions.title")
    .order(Arel.sql("MIN(events.commence_time) ASC"))
    .select("competitions.id, competitions.title")
  end

  def show
    @competition = Competition.find(params[:id])
  end
end
