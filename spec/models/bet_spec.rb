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

  it 'doit avoir le payout = odd.price * stake' do
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10)
    expect(bet.payout).to eq(odd.price * 10)
  end

  it 'ne peut pas avoir un montant négatif' do
    bet = Bet.create(user: user, odd: odd, stake: -1, status: 'pending')
    expect(bet).not_to be_valid
  end

  it 'ne peut pas avoir un montant supérieur au nombre de coins du wallet de l\'utilisateur' do
    wallet.update(coins: 100)
    bet = Bet.create(user: user, odd: odd, stake: 200, status: 'pending')
    expect(bet).not_to be_valid
  end

  it 'ne peut pas être créé si l\'odd est déjà terminé (won ou lost)' do
    odd.update(status: 'won')
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10)
    expect(bet).not_to be_valid
  end

  it 'ne peut pas être créé si l\'utilisateur a déjà parié sur cet odd' do
    Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10)
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10)
    expect(bet).not_to be_valid
  end

  it 'doit avoir une mise' do
    bet = Bet.create(user: user, odd: odd, status: 'pending', payout: odd.price * 10)
    expect(bet).not_to be_valid
  end

  it 'doit avoir un status' do
    bet = Bet.create(user: user, odd: odd, stake: 10, payout: odd.price * 10)
    expect(bet).not_to be_valid
  end

  it 'doit avoir un gain' do
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending')
    expect(bet).not_to be_valid
  end

  it 'est gagnant si l\'odd associé est gagnant' do
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10)
    odd.update(status: 'won')
    expect(bet.reload.status).to eq('won')
  end

  it 'est perdant si l\'odd associé est perdant' do
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10)
    odd.update(status: 'lost')
    expect(bet.reload.status).to eq('lost')
  end

  it 'est annulé si l\'odd associé est annulé' do
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10)
    odd.update(status: 'cancelled')
    expect(bet.reload.status).to eq('cancelled')
  end

  it 'doit débiter le wallet de l\'utilisateur' do
    expect { Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10) }.to change(wallet, :coins).by(-10)
  end

  it 'doit créditer le wallet en coins de l\'utilisateur si le pari est gagnant' do
    bet = Bet.create(user: user, odd: odd, stake: 10, status: 'pending', payout: odd.price * 10)
    odd.update(status: 'won')
    expect { bet.update(status: 'won') }.to change(wallet, :coins).by(10 + bet.calculate_diamonds * 1000)
  end

  it "met à jour le status du pari quand le odd passe à 'won'" do
    bet = Bet.create(user: user, odd: odd, stake: 500, status: 'pending', payout: odd.price * 500)

    expect {
      odd.update(status: 'won')
      bet.reload
     }.to change(bet, :status).from('pending').to('won')
  end


  it "doit créditer le wallet en diamonds de l'utilisateur si le pari est gagnant" do
    puts "wallet.diamonds: #{wallet.diamonds}"
    puts "wallet.coins: #{wallet.coins}"
    bet = Bet.create!(user: user, odd: odd, stake: 200, status: 'pending', payout: odd.price * 200)
    wallet.reload
    puts "Rechargement du wallet"
    puts "wallet.diamonds: #{wallet.diamonds}"
    puts "wallet.coins: #{wallet.coins}"

    puts "Le pari est gagnant !"
    puts "odd.status: #{odd.status}"


    odd.update(status: 'won')
    bet.reload
    wallet.reload
    expect { bet.update(status: 'won') }.to change { wallet.reload.diamonds.round(2) }.by(0.2)
    puts "wallet.diamonds: #{wallet.diamonds}"
  end
end
