class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to '/'
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
    @filters_option = [
      ["General", ""], 
      ["Course", "course"], 
      ["Professor", "professor"], 
      ["Department", "department"]
    ]

    @courses_most_reviewed = get_courses_most_reviewed(5)
    @professors_most_reviewed = get_professors_most_reviewed(5)

  end

  def destroy
    log_out
    redirect_to root_url
  end
end
