class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!


  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
