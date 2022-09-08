class SessionsController < ApplicationController

  def login_form; end

  def login
    user = User.find_by(email: params[:email])
    if !user
      flash[:alert] = "Error - Couldn't find Email"
      redirect_to login_path
    elsif pwd_check == false
      flash[:alert] = "Error - Passwords must match"
      redirect_to login_path
    elsif user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user.id)
    else
      flash[:alert] = "Error - Incorrect Password"
      redirect_to login_path
    end
  end

  private

  def pwd_check
    params[:password] == params[:password_confirmation]
  end
end