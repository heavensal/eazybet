class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: [ :update, :destroy ]

  def index
    @received_friendships = current_user.received_friendships
    @sent_friendships = current_user.sent_friendships
    @friendships = current_user.friends
  end

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      redirect_to friendships_path, notice: "Friend request sent"
    else
      redirect_back(fallback_location: profile_user_path, alert: "Could not send friend request")
    end
  end

  def update
    unless @friendship.receiver == current_user
      redirect_to profile_user_path, alert: "Not authorized" and return
    end

    if @friendship.update(status: "accepted")
      redirect_to profile_user_path, notice: "Friend request accepted"
    else
      redirect_to profile_user_path, alert: "Could not accept friend request"
    end
  end

  def destroy
    unless @friendship.sender == current_user || @friendship.receiver == current_user
      redirect_to profile_user_path, alert: "Not authorized" and return
    end

    @friendship.destroy
    redirect_to profile_user_path, notice: "Friendship removed"
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:receiver_id, :sender_id, :status)
  end
end
