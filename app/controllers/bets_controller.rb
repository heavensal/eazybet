class BetsController < ApplicationController
  def index
    @bets = current_user.bets
  end
  def create
    @bet = Bet.new(bet_params)
    @bet.payout = @bet.stake * @bet.odd.price
    @bet.user = current_user
    @bet.status = "pending"
    if @bet.save
      redirect_to root_path, notice: "Votre pari a bien été enregistré"
    else
      redirect_back(fallback_location: root_path, alert: "Erreur lors de l'enregistrement du pari")
    end
  end

  private

  def bet_params
    params.require(:bet).permit(:stake, :odd_id)
  end
end
