class EventsController < ApplicationController
  def index
    @events = Event.all
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
