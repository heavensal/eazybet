class Bet < ApplicationRecord
  belongs_to :odd
  belongs_to :user
  has_one :event, through: :odd

  validates :stake, presence: true, numericality: { greater_than: 0 }
  validates :payout, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending won lost] }

  # mis à jour du payout en fonction du status du bet
  after_update :increase_user_wallet, if: -> { status_changed? && %w[won lost].include?(status) }

  before_create :verify_wallet_coins
  after_create :decrease_wallet_coins

  private

  def increase_user_wallet
    if status == "won"
      # calcul du nombre de diamonds générés grâce au payout de coins
      # 1 diamond pour 1000 coins gagnés
      # Les coins gagnés - la mise de départ
      # Exemple: 1000 coins gagnés - 100 coins de mise = 900 coins gagnés
      # 900 coins gagnés / 1000 = 0.9 diamonds
      diamonds = calculate_diamonds
      user.wallet.diamonds += diamonds
      user.wallet.save!
    end
  end

  def verify_wallet_coins
    if user.wallet.coins < stake
      errors.add(:stake, "Vous n'avez pas assez de coins")
      throw(:abort)
    end
  end

  def decrease_wallet_coins
    user.wallet.coins -= stake
    user.wallet.save!
  end

  def calculate_diamonds
    (payout - stake) / 1000
  end
end


# create_table "bets", force: :cascade do |t|
#   t.bigint "odd_id", null: false
#   t.bigint "user_id", null: false
#   t.decimal "stake", precision: 8, scale: 2, null: false
#   t.decimal "payout", precision: 8, scale: 2, null: false
#   t.string "status"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["odd_id"], name: "index_bets_on_odd_id"
#   t.index ["user_id"], name: "index_bets_on_user_id"
# end
