class PagesController < ApplicationController
  def profile
    @user = current_user
    @wallet = @user.wallet
    @bets = @user.bets
    @bets_won = @bets.where(status: "won")
    @ratio = @bets_won.count.to_f / @bets.count.to_f
    @ratio = @ratio.nan? ? 0 : @ratio
  end

  def ranking
    # les users sont triés en fonction du nombre de diamonds qu'ils ont dans leur wallet
    @users = User.all.sort_by { |user| user.wallet.diamonds }.reverse
  end

  def challenges
  end

  def shop
  end

  def divisions
  end

  def cgu
  end

  def confidentiality
  end
end
