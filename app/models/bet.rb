class Bet < ApplicationRecord
  belongs_to :odd
  belongs_to :user
  has_one :event, through: :odd

  validates :stake, presence: true, numericality: { greater_than: 0 }
  validates :payout, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending won lost] }
end
