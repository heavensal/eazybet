class Admin::CompetitionsController < Admin::ApplicationController
  before_action :set_competition, only: %i[show edit update destroy]

  # GET /admin/competitions
  def index
    @competitions = Competition.all
  end

  # GET /admin/competitions/:id
  def show
  end

  # GET /admin/competitions/new
  def new
    @competition = Competition.new
  end

  # GET /admin/competitions/:id/edit
  def edit
  end

  # POST /admin/competitions
  def create
    @competition = Competition.new(competition_params)
    if @competition.save
      redirect_to admin_competition_path(@competition), notice: "Competition was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/competitions/:id
  def update
    if @competition.update(competition_params)
      redirect_to admin_competition_path(@competition), notice: "Competition was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /admin/competitions/:id
  def destroy
    @competition.destroy
    redirect_to admin_competitions_path, notice: "Competition was successfully destroyed."
  end

  private

  def set_competition
    @competition = Competition.find(params[:id])
  end

  def competition_params
    params.require(:competition).permit(:key, :group, :title, :description, :active, :has_outrights)
  end
end
