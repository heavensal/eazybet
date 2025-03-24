class BetsController < ApplicationController
  def index
    @bets = current_user.bets
  end
  def create
    @bet = current_user.bets.build(bet_params)
    if @bet.save
      redirect_to played_events_path, notice: "Votre pari a bien été enregistré"
    else
      redirect_back(fallback_location: root_path, alert: "Erreur lors de l'enregistrement du pari")
    end
  end

  private

  def bet_params
    params.require(:bet).permit(:money_type, :stake, :odd_id)
  end
end
