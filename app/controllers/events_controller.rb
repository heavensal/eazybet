class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :odds ]
  def index
    @competition = Competition.find(params[:competition_id])
    # récupérer les events de la competition et sur lesquels l'utilisateur n'a pas encore parié

    if user_signed_in?
      @events = @competition.events.upcoming
                  .where.not(
                    id: Event.joins(:bets)
                            .where(bets: { user_id: current_user.id })
                            .select(:id)
                  )
    else
      @events = @competition.events.upcoming
    end
  end

  def odds
    @event = Event.find(params[:id])
    @odds = @event.odds
  end

  def played
    @events = Event.joins(:bets).where(bets: { user_id: current_user.id, status: "pending" })
  end

  def finished
    @events = Event.where(status: "finished")
    @bets = current_user.bets.finished.order(updated_at: :desc)
  end

  def show
    @event = Event.includes(:odds, comments: :user).find(params[:id])
    @comment = Comment.new
  end
end
