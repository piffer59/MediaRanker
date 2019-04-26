class UsersController < ApplicationController
  before_action :find_user, only: [:current, :logout]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:error] = "User not found"
      redirect_to users_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:user][:username])
    @user = User.create(user_params) if @user.nil?

    if @user.id
      session[:user_id] = @user.id
      flash[:alert] = "Successfully logged in as existing user #{@user.username}"
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must log in to do that"
      redirect_to root_path
    end
  end

  def logout
    # user = User.find_by(id: session[:user_id])
    redirect_to root_path

    flash[:notice] = "Logged out #{@user.username}"
    session[:user_id] = nil
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
