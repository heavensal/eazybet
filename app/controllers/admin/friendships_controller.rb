class Admin::FriendshipsController < Admin::ApplicationController
  before_action :set_friendship, only: %i[show edit update destroy]

  # GET /admin/friendships
  def index
    @friendships = Friendship.all
  end

  # GET /admin/friendships/:id
  def show
  end

  # GET /admin/friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /admin/friendships/:id/edit
  def edit
  end

  # POST /admin/friendships
  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      redirect_to admin_friendship_path(@friendship), notice: "Friendship was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/friendships/:id
  def update
    if @friendship.update(friendship_params)
      redirect_to admin_friendship_path(@friendship), notice: "Friendship was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /admin/friendships/:id
  def destroy
    @friendship.destroy
    redirect_to admin_friendships_path, notice: "Friendship was successfully destroyed."
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:sender, :receiver, :status)
  end
end
