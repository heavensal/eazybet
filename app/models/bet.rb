class Bet < ApplicationRecord
  belongs_to :odd
  belongs_to :user
  has_one :event, through: :odd

  validates :money_type, presence: true, inclusion: { in: %w[coins diamonds] }
  validates :stake, presence: true, numericality: { greater_than: 0 }
  validates :odd_price, presence: true, numericality: { greater_than: 0 }
  validates :coins_to_win, presence: true, numericality: { greater_or_equal_than: 0 }
  validates :diamonds_to_win, presence: true, numericality: { greater_or_equal_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending won lost] }

  # Permet de faire un pari valide
  before_validation :set_price_and_expected_wins, on: :create

  # La création d'un pari est finalisée si le wallet de l'utilisateur a assez de coins ou de diamonds
  before_validation :check_wallet_balance, on: :create

  # Après la création d'un pari, on déduit le montant du pari du wallet de l'utilisateur
  after_commit :decrease_wallet_balance, on: :create

  # mis à jour du payout en fonction du status du bet
  after_commit :increase_wallet_balance, on: :update, if: -> {
    saved_change_to_status? && status == "won"
  }



  private

  ##### Création d'un bet #####
  def set_price_and_expected_wins
    self.odd_price = odd.price
    self.status = "pending"

    if money_type == "coins"
      self.coins_to_win = stake * odd_price
      self.diamonds_to_win = (coins_to_win - stake) / 1000.0
    else
      self.coins_to_win = 0
      self.diamonds_to_win = stake * odd_price
    end
  end
  ##############################

  ##### Mise à jour du wallet de l'utilisateur #####
  def check_wallet_balance
    if self.money_type == "coins" && self.user.wallet.coins < self.stake.to_f
      errors.add(:base, "Pas assez de coins")
    elsif self.money_type == "diamonds" && self.user.wallet.diamonds < self.stake.to_f
      errors.add(:base, "Pas assez de diamonds")
    end
  end

  def decrease_wallet_balance
    if money_type == "coins"
      user.wallet.update!(coins: user.wallet.coins - self.stake)
    else
      user.wallet.update!(diamonds: user.wallet.diamonds - self.stake)
    end
  end

  def increase_wallet_balance
    self.user.wallet.update!(
      coins: self.user.wallet.coins + self.coins_to_win,
      diamonds: self.user.wallet.diamonds + self.diamonds_to_win
    )
  end
  #################################################
end


# create_table "bets", force: :cascade do |t|
#   t.bigint "odd_id", null: false
#   t.bigint "user_id", null: false
#   t.decimal "stake", precision: 8, scale: 2, null: false
#   t.string "status"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.string "money_type", default: "coins", null: false
#   t.decimal "coins_to_win", precision: 8, scale: 2, null: false
#   t.decimal "diamonds_to_win", precision: 8, scale: 2, null: false
#   t.decimal "odd_price", precision: 8, scale: 2, null: false
#   t.index ["odd_id", "user_id"], name: "index_bets_on_odd_id_and_user_id", unique: true
#   t.index ["odd_id"], name: "index_bets_on_odd_id"
#   t.index ["user_id"], name: "index_bets_on_user_id"
# end
