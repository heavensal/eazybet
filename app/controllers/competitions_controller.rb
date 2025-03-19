class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @competitions = Competition.includes(events: [ :odds, :comments ]).all
  end

  def show
    @competition = Competition.find(params[:id])
  end
end
