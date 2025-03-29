class FollowersController < ApplicationController
  before_action :authenticate_user!

  def update
    @follower = current_user.follower

    if @follower.update(follower_params)
      current_user.wallet.increment!(:coins, 1000)
      redirect_to profile_user_path, notice: "Vous avez obtenu 1000 coins ! Merci de nous suivre !"
    else
      redirect_to profile_user_path, alert: "Could not update your preferences."
    end
  end

  private

  def follower_params
    params.require(:follower).permit(:instagram, :telegram, :x_twitter, :youtube, :tiktok)
  end
end
