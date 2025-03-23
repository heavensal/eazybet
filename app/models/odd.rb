class Odd < ApplicationRecord
  belongs_to :event
  has_many :bets, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending won lost] }

  # mis à jour des bets en fonction du status de l'odd
  after_update :update_bets, if: -> { saved_change_to_status? && %w[won lost].include?(status) }


  private

  def update_bets
    if status == "won"
      bets.find_each do |bet|
        bet.update!(status: "won")
      end
    elsif status == "lost"
      bets.find_each do |bet|
        bet.update!(status: "lost")
      end
    end
  end
end
