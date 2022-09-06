# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new; end

  def discover
    @user = User.find(params[:user_id])
  end

  def create
    new_user = User.create(user_params)
    if params_check(new_user) == false
      flash[:alert] = "Error - #{new_user.errors.full_messages}"
      redirect_to "/users/#{User.last.id}"
    else
      flash[:success] = "Welcome #{new_user.name}"
      redirect_to "/users/#{User.last.id}"
    end
  end
  
  def login_form; end

  def login
    user = User.find_by(name: params[:name], email: params[:email])
    if !user
      flash[:alert] = "Error - Could'nt find Name or Email"
      redirect_to login_path
    elsif pwd_check == false
      flash[:alert] = "Error - Passwords must match"
      redirect_to login_path
    elsif user&.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user.id)
    else
      flash[:alert] = "Error - Incorrect Password"
      redirect_to login_path
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def params_check(user)
    if user.name.empty? || user.email.empty? || user.password.empty? || user.password_confirmation.empty?
      false
    elsif user.password != user.password_confirmation
      false
    else
      true
    end
  end

  def pwd_check
    params[:password] == params[:password_confirmation]
  end
end

# --- attempting helper methods for login verification --- #

  # def login_check(user)
  #   users = User.all
  #   users.each do |u|
  #     if u.name.include?(user.name) && u.email.include?(u.email)
  #       true
  #     else
  #       false
  #     end
  #   end
  # end
