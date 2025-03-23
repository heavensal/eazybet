require 'rails_helper'

##### TEST #####
#
# Path: spec/models/bet_spec.rb
#
# Un pari est toujours associé à un utilisateur
# Un pari est toujours associé à un odd
# Un pari ne peut pas avoir un montant négatif
# Un pari ne peut pas avoir un montant supérieur au nombre de coins du wallet de l'utilisateur
# Un pari ne peut pas être créé si l'odd est déjà terminé (won ou lost)
# Un pari ne peut pas être créé si l'utilisateur a déjà parié sur cet odd
# Un pari a toujours une mise (:stake)
# Un pari a toujours un status (:status)
# Un pari a toujours un gain (:payout)
# Un pari est gagnant si l'odd associé est gagnant
# Un pari est perdant si l'odd associé est perdant
# Bet story:
#  - Un utilisateur crée un pari sur un odd qui est pending
#    - L'utilisateur a assez de coins
#    - L'utilisateur n'a pas déjà parié sur cet odd
#    - Le odd est toujours pending
#  - L'utilisateur utilise ses coins pour créer le pari, on débite son wallet
#  - Le pari est créé
#  - On crée les scores de l'event
#  - On détermine le status du pari
#  - On met à jour le status du pari
#    - Si l'odd est gagnant, le pari est gagnant
#    - Si l'odd est perdant, le pari est perdant
#    - Si l'odd est annulé, le pari est annulé
#  - On met à jour le wallet de l'utilisateur
#    - Si le pari est gagnant, on crédite le wallet de l'utilisateur
#    - Si le pari est perdant, on ne fait rien
RSpec.describe Bet, type: :model do
  let(:user) { create(:user) }
  let(:wallet) { user.wallet.tap { |w| w.update(coins: 200) } }
  let(:competition) { create(:competition) }
  let(:event) { create(:event, competition: competition) }
  let(:odd) { event.odds.first || create(:odd, event: event, price: 2.0) }

  it 'a toujours un utilisateur, un odd, et doit avoir le payout = odd.price * stake' do
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending')
    expect(bet.payout).to eq(odd.price * 10)
  end

  it 'ne peut pas avoir un montant négatif' do
    bet = Bet.new(user: user, odd: odd, stake: -1, status: 'pending')
    expect(bet).not_to be_valid
    expect(bet.errors[:stake]).to include("must be greater than or equal to 0")
  end

  it 'ne peut pas avoir un montant supérieur au nombre de coins du wallet de l\'utilisateur' do
    wallet.update(coins: 100)
    bet = Bet.new(user: user, odd: odd, stake: 200, status: 'pending')
    expect(bet).not_to be_valid
    expect(bet.errors[:stake]).to include("is greater than your available balance")
  end
end
