class Competition < ApplicationRecord
  has_many :events, -> { order(:commence_time) }, dependent: :destroy


  def pending_events
    self.events.where(status: "pending")
  end

  def finished_events
    self.events.where(status: "finished")
  end

  def cancelled_events
    self.events.where(status: "cancelled")
  end
end
