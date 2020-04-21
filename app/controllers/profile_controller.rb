class ProfileController < ApplicationController
  before_action :login_required
  skip_before_action :verify_authenticity_token

  def view_profile
    @user_reviews = sort_by_created(current_user.reviews)
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

  def sort_by_created(sth)
    rtn = sth.sort_by(&:updated_at).reverse!
    return rtn
  end
end
