class ReviewsController < ApplicationController
  before_action :login_required
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :set_review, only: [:show, :edit, :update, :destroy]

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
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save

        course_r = CourseRating.create(
          review_id: @review.id, 
          cat1: form_input[:course_cat1].to_i, 
          cat2: form_input[:course_cat2].to_i, 
          cat3: form_input[:course_cat3].to_i, 
          cat4: form_input[:course_cat4].to_i, 
          cat5: form_input[:course_cat5].to_i, 
          content: form_input[:course_content]
        )

        professor_r = ProfessorRating.create(
          review_id: @review.id, 
          cat1: form_input[:professor_cat1].to_i, 
          cat2: form_input[:professor_cat2].to_i, 
          cat3: form_input[:professor_cat3].to_i, 
          cat4: form_input[:professor_cat4].to_i, 
          cat5: form_input[:professor_cat5].to_i, 
          strength: form_input[:professor_strength],
          improvement: form_input[:professor_improvement]
        )
         
         format.html { redirect_to '/view_profile', notice: 'Review was successfully created.' }
         format.json { render :show, status: :created, location: @review }
       else
         format.html { render :new }
         format.json { render json: @review.errors, status: :unprocessable_entity }
       end
     end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:student_id, :title, :rate_up, :rate_down)
    end
end
