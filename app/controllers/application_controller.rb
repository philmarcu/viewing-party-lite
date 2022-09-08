# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_admin

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !current_user
      redirect_to root_path
      flash[:alert] = "Invalid access to page, must be logged in"
    end
  end

  def current_admin
    redirect_to(root_path) unless current_user&.admin?
  end

  def home; end
end

# --- future stub syntax for user tests 
# allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user
