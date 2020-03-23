class ReviewsController < ApplicationController
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
    form_input = params[:review]

    u_id = session[:user_id]
    p_id = form_input[:professor_id]
    c_id = form_input[:course_id]
    t = form_input[:title]

    @review = Review.new(user_id:u_id, course_id: c_id, professor_id: p_id, title: t, rate_up: 0, rate_down: 0)
    
    respond_to do |format|
      if @review.save

        course_r = CourseRating.create(
          review_id: @review.id, 
          cat1: form_input[:course_cat1], 
          cat2: form_input[:course_cat2], 
          cat3: form_input[:course_cat3], 
          cat4: form_input[:course_cat4], 
          cat5: form_input[:course_cat5], 
          content: form_input[:course_content]
        )

        professor_r = ProfessorRating.create(
          review_id: @review.id, 
          cat1: form_input[:professor_cat1], 
          cat2: form_input[:professor_cat2], 
          cat3: form_input[:professor_cat3], 
          cat4: form_input[:professor_cat4], 
          cat5: form_input[:professor_cat5], 
          strength: form_input[:professor_strength],
          improvement: form_input[:professor_improvement]
        )

         format.html { redirect_to @review, notice: 'Review was successfully created.' }
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
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
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
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
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
      params.require(:review).permit(
        :user_id, 
        :title, 
        :course_id, 
        :professor_id,
      )
    end
end
