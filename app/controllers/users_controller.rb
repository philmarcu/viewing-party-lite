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
    if params[:name].empty? || params[:email].empty? || params[:password].empty?
      flash[:alert] = "Error - #{new_user.errors.full_messages}"
      redirect_to "/users/#{User.last.id}"
    elsif params[:password] != params[:password_confirmation]
      flash[:alert] = "Error - Passwords must match"
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
end
