class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @competitions = Competition.includes(events: :odds)
  end

  def show
    @competition = Competition.find(params[:id])
  end
end
