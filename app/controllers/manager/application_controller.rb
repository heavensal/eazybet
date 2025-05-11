class Manager::ApplicationController < ApplicationController
  before_action :authenticate_manager!

  def authenticate_manager!
    unless current_user&.manager? || current_user&.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
