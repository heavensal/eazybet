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
    # ma relation d'amitié avec le @user si'il y en a une
    @friendship = Friendship.find_by(sender: current_user, receiver: @user) || Friendship.find_by(sender: @user, receiver: current_user) || Friendship.new
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
  @bets_won = @bets.where(status: 'won')
  @bets_lost = @bets.where(status: 'lost')

  total_played = @bets_won.size + @bets_lost.size

  @ratio = total_played.positive? ? ((@bets_won.size.to_f / total_played) * 100).round(2) : 0
end

  def watch_ads
    current_user.has_watched_ads
    redirect_back(fallback_location: root_path)
  end
end
