class UsersController < ApplicationController
  before_action :authorize_user!, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:notice] = "You gone signed up"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @location = Location.order(created_at: :desc).find_by(user_id: @user.id)
  end

  private

  def authorize_user!
    unless current_user&.is_admin?
      flash[:alert] = 'Admin access only'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
