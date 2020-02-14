class CourseRatingsController < ApplicationController
  before_action :set_course_rating, only: [:show, :edit, :update, :destroy]

  # GET /course_ratings
  # GET /course_ratings.json
  def index
    @course_ratings = CourseRating.all
  end

  # GET /course_ratings/1
  # GET /course_ratings/1.json
  def show
  end

  # GET /course_ratings/new
  def new
    @course_rating = CourseRating.new
  end

  # GET /course_ratings/1/edit
  def edit
  end

  # POST /course_ratings
  # POST /course_ratings.json
  def create
    @course_rating = CourseRating.new(course_rating_params)

    respond_to do |format|
      if @course_rating.save
        format.html { redirect_to @course_rating, notice: 'Course rating was successfully created.' }
        format.json { render :show, status: :created, location: @course_rating }
      else
        format.html { render :new }
        format.json { render json: @course_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_ratings/1
  # PATCH/PUT /course_ratings/1.json
  def update
    respond_to do |format|
      if @course_rating.update(course_rating_params)
        format.html { redirect_to @course_rating, notice: 'Course rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_rating }
      else
        format.html { render :edit }
        format.json { render json: @course_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_ratings/1
  # DELETE /course_ratings/1.json
  def destroy
    @course_rating.destroy
    respond_to do |format|
      format.html { redirect_to course_ratings_url, notice: 'Course rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_rating
      @course_rating = CourseRating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_rating_params
      params.require(:course_rating).permit(:review_id, :cat1, :cat2, :cat3, :cat4, :cat5, :content)
    end
end
