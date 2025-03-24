class UsersController < ApplicationController
  before_action :authenticate_user!

  def ranking
    @users = User.all.sort_by { |user| user.wallet.diamonds }.reverse
  end

  # pour le classement des amis
  def ranking_friends
    @users = current_user.friends.sort_by { |user| user.wallet.diamonds }.reverse
  end

  # pour la view d'un user
  def show
    @user = User.find(params[:id])
    @wallet = @user.wallet
    @bets = @user.bets
    @bets_won = @bets.where(status: "won")
    @ratio = @bets_won.count.to_f / @bets.count.to_f
    @ratio = @ratio.nan? ? 0 : @ratio
  end

  # pour la view du profil de l'utilisateur connecté
  def profile
    @user = current_user
    @wallet = @user.wallet
    @bets = @user.bets
    @bets_won = @bets.where(status: "won")
    @ratio = @bets_won.count.to_f / @bets.count.to_f
    @ratio = @ratio.nan? ? 0 : @ratio
  end
end
