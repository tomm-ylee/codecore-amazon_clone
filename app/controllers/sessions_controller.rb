class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    # location = Location.new(user: user, ip_address: request.remote_ip)
    location = Location.new(user: user, ip_address: '50.64.108.1')
    location.save
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You gone signed in'
      redirect_to root_path
    else
      flash.now[:alert] = 'Wrong email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You gone signed out'
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
