# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, 
                :current_admin, 
                :require_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    redirect_to(root_path) unless current_user&.admin?
  end

  def home; end
end

# --- future stub syntax for user tests 
# allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user
