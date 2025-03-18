class EventsController < ApplicationController
  skip_before_action :authenticate_user!
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
    @event = Event.find(params[:id])
    @comments = @event.comments
    @comment = Comment.new
  end
end
