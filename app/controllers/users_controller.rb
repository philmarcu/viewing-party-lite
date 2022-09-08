class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new; end

  def discover
    @user = User.find(params[:user_id])
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome #{new_user.name}"
      redirect_to "/users/#{User.last.id}"
    else
      flash[:alert] = "Error - #{new_user.errors.full_messages.join(" , ")}"
      redirect_to "/users/#{User.last.id}"
    end
  end
  
  private
  
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end

# --- not sure how to implement require_user action ---#

# def require_user
#   if !current_user
#     redirect_to root_path
#     flash[:alert] = "Invalid access to page, must be logged in"
#   end
# end

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

# ---- old user#create action + helper method ---- #

# if params_check(new_user) == false
#   flash[:alert] = "Error - #{new_user.errors.full_messages}"
#   redirect_to "/users/#{User.last.id}"
# else
#   session[:user_id] = new_user.id
#   flash[:success] = "Welcome #{new_user.name}"
#   redirect_to "/users/#{User.last.id}"
# end


# def params_check(user)
#   if user.name.empty? || user.email.empty? || user.password.empty? || user.password_confirmation.empty?
#     false
#   elsif user.password != user.password_confirmation
#     false
#   else
#     true
#   end
# end