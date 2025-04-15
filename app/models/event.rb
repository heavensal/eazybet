class Event < ApplicationRecord
  belongs_to :competition

  has_many :comments, dependent: :destroy

  has_many :odds, dependent: :destroy
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

  # il faut récupérer tous les prochains events jusqu'a 72h après le prochain event, quelque chose comme +72h au prochain event.commence_time
  def self.upcoming
    first_event = where("commence_time > ?", Time.now).order(:commence_time).first
    return none unless first_event
    where(commence_time: first_event.commence_time..(first_event.commence_time + 72.hours))
  end


  # il faut récupérer tous les events passés jusqu'a 72h avant le prochain event, quelque chose comme -72h au prochain event.commence_time
  def self.past
    where("commence_time < ?", Time.now).where("commence_time > ?", Time.now - 72.hours)
  end
end
