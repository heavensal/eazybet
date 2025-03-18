class CompetitionsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @competitions = Rails.cache.fetch("competitions_with_events_odds_comments", expires_in: 10.minutes) do
      Competition
        .select("competitions.*, COUNT(comments.id) AS comments_count")
        .includes(events: :odds)
        .left_joins(events: :comments)
        .where(events: { commence_time: Time.zone.now.. })
        .group("competitions.id, events.id")
        .order("events.commence_time ASC")
    end
  end

  def show
    @competition = Competition.find(params[:id])
  end
end
