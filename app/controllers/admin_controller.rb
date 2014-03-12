class AdminController < ApplicationController
  # before_filter :authenticate_user!, :authenticate_admin!

  def index

  end

  private

  def authenticate_admin!
    unless current_user.has_any_role? :admin, :super_admin
      redirect_to root_path, alert: "You are not authorized to access this area."
    end
  end
end
