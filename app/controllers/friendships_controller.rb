class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: [ :update, :destroy ]

  def create
    receiver = User.find_by(id: params[:user_id])

    if receiver.nil? || receiver == current_user
      redirect_to profile_path, alert: "Invalid friend request" and return
    end

    @friendship = Friendship.new(sender: current_user, receiver: receiver)

    if @friendship.save
      redirect_to profile_path, notice: "Friend request sent"
    else
      redirect_to profile_path, alert: @friendship.errors.full_messages.to_sentence
    end
  end

  def update
    unless @friendship.receiver == current_user
      redirect_to profile_path, alert: "Not authorized" and return
    end

    if @friendship.update(status: "accepted")
      redirect_to profile_path, notice: "Friend request accepted"
    else
      redirect_to profile_path, alert: "Could not accept friend request"
    end
  end

  def destroy
    unless @friendship.sender == current_user || @friendship.receiver == current_user
      redirect_to profile_path, alert: "Not authorized" and return
    end

    @friendship.destroy
    redirect_to profile_path, notice: "Friendship removed"
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end
