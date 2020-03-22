class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to '/welcome'
    else
      flash[:danger] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def login
  end

  def welcome
    if logged_in?
      @user = current_user
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
