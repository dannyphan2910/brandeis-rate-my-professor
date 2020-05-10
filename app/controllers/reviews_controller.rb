class ReviewsController < ApplicationController
  before_action :login_required
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_helper

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show

  end

  # GET /reviews/new
  def new
    @review = Review.new
    
  end

  # GET /reviews/1/edit
  def edit
    f_id = params[:id]

    @review = Review.find(f_id)
    @course_rating = CourseRating.find_by(review_id: f_id)
    @professor_rating = ProfessorRating.find_by(review_id: f_id)
    @course = Course.find(@review.course_id)
    @professor = Professor.find(@review.professor_id)
    respond_to do |format|
      format.js
    end
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
 
    respond_to do |format|
      begin
        if @review.save 
          format.js {render 'reviews/create'}
          format.json { render :show, status: :created, location: @review }
        else
          format.js { render 'reviews/fail' }
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordNotFound
        format.js { render 'reviews/fail' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
     end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_edit_params)
        format.html { redirect_to '/view_profile', notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to '/view_profile', notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def filter_course_by_year
    @filtered_course = @review_helper.filter_course_by_year_helper params[:year]
    @filtered_course
  end

  def filter_professor_by_course
    @filtered_professor = @review_helper.filter_professor_by_course_helper params[:year], params[:gcname].split(":")[0]
    @filtered_professor
  end

  def open_edit_modal
    f_id = params[:id]
    @review = Review.find(f_id)
    respond_to do |format| 
      format.js {render 'reviews/open_edit_modal'}
    end
  end

  private
    def set_helper
      @review_helper = ReviewForm.new(current_user)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      if params[:review]
        form_input = params[:review]
        c_year = form_input[:course_year].split(" ")[0]
        c_semester = form_input[:course_year].split(" ")[1]
        u_id = @current_user.id
        p_id = form_input[:professor_id]
        c_code = form_input[:course_id].split(":")[0]
        gc_id = GeneralCourse.find_by(course_code: c_code).id
        c_id = Course.find_by(general_course_id: gc_id, professor_id: p_id, year: c_year, semester: c_semester).id
        params[:review][:course_id] = c_id
        params[:review][:user_id] = u_id
      end
      return params.require(:review).permit(
        :user_id,
        :title,
        :course_id,
        :professor_id,
        professor_rating_attributes:[:cat1, :cat2, :cat3, :cat4, :cat5, :strength, :improvement],
        course_rating_attributes:[:cat1, :cat2, :cat3, :cat4, :cat5, :content]
      ).merge({user_id: u_id})
    end

    def review_edit_params
      params.require(:review).permit(
        :title,
        professor_rating_attributes:[:id, :cat1, :cat2, :cat3, :cat4, :cat5, :strength, :improvement],
        course_rating_attributes:[:id, :cat1, :cat2, :cat3, :cat4, :cat5, :content]
      )
    end
end