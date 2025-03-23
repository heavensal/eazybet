require 'rails_helper'

##############################################
# TEST
# Path: spec/models/wallet_spec.rb
#
# Un wallet est toujours associé à un utilisateur
# Un wallet ne peut pas avoir des coins négatifs
# Un wallet ne peut pas avoir des diamonds négatifs
# Un user possède toujorus un wallet

RSpec.describe Wallet, type: :model do
  let(:wallet) { create(:wallet) }

  it 'is valid' do
    expect(wallet).to be_valid
  end

  it 'is associated to a user' do
    expect(wallet.user).to be_a(User)
  end

  it 'cannot have negative coins' do
    wallet.coins = -1
    expect(wallet).not_to be_valid
  end

  it 'cannot have negative diamonds' do
    wallet.diamonds = -1
    expect(wallet).not_to be_valid
  end

  it 'belongs to a user' do
    expect(wallet.user).to be_a(User)
  end
end
