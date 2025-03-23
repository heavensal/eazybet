class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show ]

  def ranking
    @users = User.all.sort_by { |user| user.wallet.diamonds }.reverse
  end

  def ranking_friends
    @users = current_user.friends.sort_by { |user| user.wallet.diamonds }.reverse
  end

  def show
  end

  def profile
    @user = current_user
    @wallet = @user.wallet
    @bets = @user.bets
    @bets_won = @bets.where(status: "won")
    @ratio = @bets_won.count.to_f / @bets.count.to_f
    @ratio = @ratio.nan? ? 0 : @ratio
  end
end
