class Admin::OddsController < Admin::ApplicationController
  before_action :set_odd, only: %i[show edit update destroy]

  # GET /admin/odd
  def index
    @odds = Odd.all
  end

  # GET /admin/odd/:id
  def show
  end

  # GET /admin/odd/new
  def new
    @odd = Odd.new
  end

  # GET /admin/odd/:id/edit
  def edit
  end

  # POST /admin/odd
  def create
    @odd = Odd.new(odd_params)
    if @odd.save
      redirect_to admin_odd_path(@odd), notice: "Odd was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/odd/:id
  def update
    if @odd.update(odd_params)
      redirect_to admin_odd_path(@odd), notice: "Odd was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /admin/odd/:id
  def destroy
    @odd.destroy
    redirect_to admin_odd_path, notice: "Odd was successfully destroyed."
  end

  private

  def set_odd
    @odd = Odd.find(params[:id])
  end

  def odd_params
    params.require(:odd).permit(:home_win, :draw, :away_win, :event_id)
  end
end
