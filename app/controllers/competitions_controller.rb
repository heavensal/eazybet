class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @competitions = Competition.select(:id, :title)
  end

  def show
    @competition = Competition.find(params[:id])
  end
end
