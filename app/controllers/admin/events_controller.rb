class Admin::EventsController < Admin::ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # GET /admin/events
  def index
    @events = Event.all
  end

  # GET /admin/events/:id
  def show
  end

  # GET /admin/events/new
  def new
    @event = Event.new
  end

  # GET /admin/events/:id/edit
  def edit
  end

  # POST /admin/events
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_event_path(@event), notice: "Event was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/events/:id
  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /admin/events/:id
  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: "Event was successfully destroyed."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:id, :commence_time, :home_team, :away_team, :status, :competition_id)
  end
end
