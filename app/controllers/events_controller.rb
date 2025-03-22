class EventsController < ApplicationController
  def index
    @competition = Competition.find(params[:competition_id])
    @events = @competition.events.sorted_by_commence_time
  end

  def odds
    @event = Event.find(params[:id])
    @odds = @event.odds
  end

  def played
    @events = Event.joins(:bets).where(bets: { user_id: current_user.id })
  end

  def finished
    @events = Event.where(status: "finished")
  end

  def show
    @event = Event.includes(:odds, comments: :user).find(params[:id])
    @comment = Comment.new
  end
end
