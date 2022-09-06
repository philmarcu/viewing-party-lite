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

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def params_check(user)
    if user.password != user.password_confirmation
      false
    elsif user.name.empty? || user.email.empty? || user.password.empty?
      false
    else
      true
    end
  end
end
