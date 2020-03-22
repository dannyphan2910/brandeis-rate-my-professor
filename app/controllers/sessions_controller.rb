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
    @courses_most_reviewed = get_courses_most_reviewed(5)
    @professors_most_reviewed = get_professors_most_reviewed(5)
  end

  def get_courses_most_reviewed num
    ids = Course.joins(:reviews).group(:id).count(:all).sort_by {|k,v| v}.reverse.first(5).to_h.keys
    courses = Course.where(id: ids)
    result = []
    courses.each do |course|
      course_hash = course.as_json
      ratings = course.course_ratings
      course_hash['avg_cat1'] = ratings.average(:cat1).round(2)
      course_hash['avg_cat2'] = ratings.average(:cat2).round(2)
      course_hash['avg_cat3'] = ratings.average(:cat3).round(2)
      course_hash['avg_cat4'] = ratings.average(:cat4).round(2)
      course_hash['avg_cat5'] = ratings.average(:cat5).round(2)
      course_hash['total_reviews'] = course.reviews.length
      result.push(course_hash)
    end
    puts result
    return result
  end

  def get_professors_most_reviewed num
    ids = Course.joins(:reviews).group(:id).count(:all).sort_by {|k,v| v}.reverse.first(5).to_h.keys
    courses = Course.where(id: ids)
    result = []
    courses.each do |course|
      prof = course.professor
      prof_hash = prof.as_json
      ratings = course.reviews.map { |review| review.professor_rating }
      prof_hash['avg_cat1'] = (ratings.map { |r| r.cat1 }.inject{ |sum, el| sum + el }.to_f / ratings.size).round(2)
      prof_hash['avg_cat2'] = (ratings.map { |r| r.cat2 }.inject{ |sum, el| sum + el }.to_f / ratings.size).round(2)
      prof_hash['avg_cat3'] = (ratings.map { |r| r.cat3 }.inject{ |sum, el| sum + el }.to_f / ratings.size).round(2)
      prof_hash['avg_cat4'] = (ratings.map { |r| r.cat4 }.inject{ |sum, el| sum + el }.to_f / ratings.size).round(2)
      prof_hash['avg_cat5'] = (ratings.map { |r| r.cat5 }.inject{ |sum, el| sum + el }.to_f / ratings.size).round(2)
      prof_hash['total_reviews'] = course.reviews.length
      result.push(prof_hash)
    end
    puts result
    return result
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
