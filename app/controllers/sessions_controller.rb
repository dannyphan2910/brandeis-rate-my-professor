class SessionsController < ApplicationController
  def new
  end

  def create
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
      # ["Department", "department"]
    ]

    @courses_most_reviewed = get_courses_most_reviewed(5)
    @professors_most_reviewed = get_professors_most_reviewed(5)

    # delete stored OAuth data 
    session.delete('devise.google_data') if session['devise.google_data']
    session.delete('devise.facebook_data') if session['devise.facebook_data']
  end

  def destroy
  end
end
