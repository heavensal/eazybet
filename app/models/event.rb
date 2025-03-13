class Event < ApplicationRecord
  belongs_to :competition

  # ne peut avoir que 3 odds maximum
  has_many :odds, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bets, through: :odds
  has_many :scores, dependent: :destroy

  validates :home_team, presence: true
  validates :away_team, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending finished cancelled] }
  validates :commence_time, presence: true
  validates :odds, length: { maximum: 3 }

  def self.sorted_by_commence_time
    order(commence_time: :asc)
  end
end
