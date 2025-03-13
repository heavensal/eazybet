class Odd < ApplicationRecord
  belongs_to :event
  has_many :bets, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending won lost] }
end
