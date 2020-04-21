class EnrollmentsController < ApplicationController
  before_action :login_required
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    user_id = current_user.id
    general_course_id = params[:general_course_id]
    puts user_id, general_course_id
    if !Enrollment.exists?(user_id: user_id, general_course_id: general_course_id)
      Enrollment.create(user_id: user_id, general_course_id: general_course_id)
    end
    @user_courses = current_user.general_courses.order(:course_code)
    @courses = GeneralCourse.not_taken_by_user(current_user.id).search(params[:search_text_courses])
    respond_to do |format|
      format.js { }
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    # user_id = current_user.id
    # general_course_id = params[:general_course_id]
    # puts user_id, general_course_id
    # if Enrollment.exists?(user_id: user_id, general_course_id: general_course_id)
    #   Enrollment.find_by(user_id: user_id, general_course_id: general_course_id).delete
    # end
    @user_courses = current_user.general_courses.order(:course_code)
    @courses = GeneralCourse.not_taken_by_user(current_user.id).search(params[:search_text_courses])
    respond_to do |format|
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:user_id, :general_course_id)
    end
end
