class Manager::TeamsController < ApplicationController
  before_action :set_team, only: [ :show, :edit, :update, :destroy ]

  def index
    @teams = Team.order(:full_name)
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to manager_teams_path, notice: "Team was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to manager_teams_path, notice: "Team was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    redirect_to manager_teams_path, notice: "Team was successfully destroyed."
  end


  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:full_name, :odd_api_id, :short_name, :english_name, :french_name, :spanish_name, :picture)
  end
end
