class ProfileController < ApplicationController
  before_action :login_required
  skip_before_action :verify_authenticity_token

  def view_profile
    @user_reviews = current_user.reviews.order(updated_at: :desc, created_at: :asc)
    @user_courses = current_user.general_courses.order(:course_code)
    if params[:search_text_courses]
      if params[:search_text_courses].blank?
        @courses = []
      else
        @courses = GeneralCourse.not_taken_by_user(current_user.id).search(params[:search_text_courses])
      end
    end

    respond_to do |format|
      format.html { }
      format.js { }
    end
  end

  def upload_avatar
    if params[:avatar]
      current_user.avatar.attach(params[:avatar])
      respond_to do |format|
        format.html { redirect_to '/view_profile', notice: 'Your new profile picture is successfully uploaded' }
      end
    end
  end
end
