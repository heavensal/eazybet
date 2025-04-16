class Manager::AdsController < Manager::ApplicationController
  before_action :set_ad, only: [ :show, :edit, :update, :destroy ]

  # GET /manager/ads
  # GET /manager/ads.json
  def index
    @ads = Ad.all
  end

  def show
  end

  def new
    @ad = Ad.new
  end

  def edit
  end

  def create
    @ad = Ad.new(ad_params)
    if @ad.save
      redirect_to manager_ads_path, notice: "Ad was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ad.update(ad_params)
      redirect_to manager_ads_path, notice: "Ad was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @ad.destroy
    redirect_to manager_ads_path, notice: "Ad was successfully deleted."
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:title, :description, :video, :active)
  end
end
