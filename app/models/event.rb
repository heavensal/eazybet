class Event < ApplicationRecord
  belongs_to :competition

  has_many :odds, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bets, through: :odds
  has_many :scores, dependent: :destroy

  validates :home_team, presence: true
  validates :away_team, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending live finished cancelled] }
  validates :commence_time, presence: true


  # ne peut avoir que 3 odds maximum
  validates :odds, length: { maximum: 3 }

  # ne peut avoir que 2 scores maximum
  validates :scores, length: { maximum: 2 }


  ############################################################
  # FAIRE CORRESPONDRE LES NOMS DES EQUIPES AVEC LES ODDS
  def home_team_odd
    odds.find_by(name: home_team)
  end

  def away_team_odd
    odds.find_by(name: away_team)
  end

  def draw_odd
    odds.find_by(name: "Draw")
  end
  ############################################################

  ############################################################
  # FAIRE CORRESPONDRE LES NOMS DES EQUIPES AVEC LES SCORES
  def home_team_score
    scores.find_by(name: home_team)
  end

  def away_team_score
    scores.find_by(name: away_team)
  end
  ############################################################


  def self.sorted_by_commence_time
    order(commence_time: :asc)
  end

  def self.pending
    where(status: "pending")
  end

  def self.live
    where(status: "live")
  end

  def self.finished
    where(status: "finished")
  end

  def self.cancelled
    where(status: "cancelled")
  end
end
