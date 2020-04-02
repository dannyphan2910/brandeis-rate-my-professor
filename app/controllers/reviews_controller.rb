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
    form_input = params[:review]

    u_id = session[:user_id]
    p_id = form_input[:professor_id]
    c_code = form_input[:course_id].split(":")[0]
    gc_id = GeneralCourse.find_by(course_code: c_code).id
    c_year = form_input[:course_year]
    c_id = Course.find_by(general_course_id: gc_id, professor_id: p_id, year: c_year).id
    t = form_input[:title]
    
    @review = Review.new(user_id:u_id, course_id: c_id, professor_id: p_id, title: t, rate_up: 0, rate_down: 0)
    
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
         
         format.js {render 'reviews/create'}
         format.json { render :show, status: :created, location: @review }
       else
         format.html { render 'reviews/fail' }
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

  def filter_course_by_year
    filter = Course.where(params[:year])
    used = []
    @filtered_course = ["Select A Course"]
    filter.each do |f|
      gcid = f.general_course_id
      if !used.include?(gcid)
        @filtered_course.push(GeneralCourse.find(gcid).show_course_info)
        used.push(gcid)
      end
    end
    return @filtered_course
  end

  def filter_professor_by_course
    gcid = GeneralCourse.find_by(course_code: params[:gcname].split(":")[0])
    course = Course.where(general_course_id: gcid, year: params[:year])
    @filtered_professor = []
    course.each do |c|
      @filtered_professor.push(c.professor)
    end
    return @filtered_professor
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

# class AutocompleteSearchService
#   include HTTParty
#   base_uri "https://api.github.com/"

#   def initialize(term)
#     @term = term
#   end

#   def call
#     { users: users, skills: skills }
#   end

#   private

#   def users
#     response = self.class.get("/search/users", query: { q: @term })
#     response["items"].map { |u| u["login"] }.take(5)
#   end

#   def skills
#     Skill.find_by_name(@term).map(&:name).take(5)
#   end
# end
