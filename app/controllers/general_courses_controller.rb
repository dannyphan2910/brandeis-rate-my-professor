class GeneralCoursesController < ApplicationController
  before_action :set_general_course, only: [:show, :edit, :update, :destroy, :match]

  # GET /general_courses
  # GET /general_courses.json
  def index
    @general_courses = GeneralCourse.all
  end

  # GET /general_courses/1
  # GET /general_courses/1.json
  def show
    @reviews = @general_course.reviews
    @courses = @general_course.courses.order(year: :desc, semester: :asc)
    @highest_rated_review = @reviews.ordered_by_rate_up.first
    @overall_stat = @general_course.as_json.merge! @general_course.get_average

    if current_user && current_user.preference
      @score = match_score @general_course, current_user.preference.likes_participation, current_user.preference.likes_workload, current_user.preference.likes_testing 
      @indicator = analyze_score @score
    end
  end

  # POST /general_courses/1/match
  def match
    if params[:pref_participation] && params[:pref_workload] && params[:pref_grading] 
      likes_participation = params[:pref_participation] == 'no'
      likes_workload = params[:pref_workload] == 'no'
      likes_testing = params[:pref_grading] == 'no'

      @score = match_score @general_course, likes_participation, likes_workload, likes_testing
      @indicator = analyze_score @score

      respond_to do |format|
        format.js
      end
    end
  end

  # GET /general_courses/new
  def new
    @general_course = GeneralCourse.new
  end

  # GET /general_courses/1/edit
  def edit
  end

  # POST /general_courses
  # POST /general_courses.json
  def create
    @general_course = GeneralCourse.new(general_course_params)

    respond_to do |format|
      if @general_course.save
        format.html { redirect_to @general_course, notice: 'General course was successfully created.' }
        format.json { render :show, status: :created, location: @general_course }
      else
        format.html { render :new }
        format.json { render json: @general_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /general_courses/1
  # PATCH/PUT /general_courses/1.json
  def update
    respond_to do |format|
      if @general_course.update(general_course_params)
        format.html { redirect_to @general_course, notice: 'General course was successfully updated.' }
        format.json { render :show, status: :ok, location: @general_course }
      else
        format.html { render :edit }
        format.json { render json: @general_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /general_courses/1
  # DELETE /general_courses/1.json
  def destroy
    @general_course.destroy
    respond_to do |format|
      format.html { redirect_to general_courses_url, notice: 'General course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_general_course
      @general_course = GeneralCourse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def general_course_params
      params.require(:general_course).permit(:course_code, :course_title, :course_description)
    end
end
