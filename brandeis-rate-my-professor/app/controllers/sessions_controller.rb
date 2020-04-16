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
      ["Department", "department"]
    ]

    @courses_most_reviewed = get_courses_most_reviewed(5)
    @professors_most_reviewed = get_professors_most_reviewed(5)

  end

  def destroy
  end
end
