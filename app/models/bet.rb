class Bet < ApplicationRecord
  belongs_to :odd
  belongs_to :user
  has_one :event, through: :odd

  validates :stake, presence: true, numericality: { greater_than: 0 }
  validates :payout, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending won lost] }

  # mis à jour du payout en fonction du status du bet
  after_update :update_user_wallet, if: -> { status_changed? && %w[won lost].include?(status) }

  private


  def update_user_wallet
    if status == "won"
      user.wallet += payout
      user.wallet.save!
    end
  end
end
