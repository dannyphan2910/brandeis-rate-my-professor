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
    
    # rid = params[:id]
    # ep = params[:review]
    # cr = CourseRating.find_by(review_id: rid)
    # cr.update(cat1:ep[:e_course_cat1], cat2:ep[:e_course_cat2], cat3: ep[:e_course_cat3], cat4:ep[:e_course_cat4], cat5: ep[:e_course_cat5], content: ep[:course_content])
    # pr = ProfessorRating.find_by(review_id: rid)
    # pr.update(cat1:ep[:e_professor_cat1], cat2:ep[:e_professor_cat2], cat3: ep[:e_professor_cat3], cat4:ep[:e_professor_cat4], cat5: ep[:e_professor_cat5], strength: ep[:professor_strength], improvement: ep[:professor_improvement])
    
    
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
    ys = params[:year]
    y = ys.split(" ")[0]
    s = ys.split(" ")[1]
    filter = Course.where(year:y,semester:s)
    user_reviewed_courses = filter_user_reviewed_courses
    used = []
    @filtered_course = []
    filter.each do |f|
      cid = f.id
      gcid = f.general_course_id
      if !used.include?(gcid) && !user_reviewed_courses.include?(cid)
        @filtered_course.push(GeneralCourse.find(gcid).show_course_info)
        used.push(gcid)
      end
    end
    @filtered_course = @filtered_course.sort do |a,b|
      if a.split(" ")[0] > b.split(" ")[0]
        1
      elsif a.split(" ")[0] < b.split(" ")[0]
        -1
      else
        if only_number(a.split(" ")[1]) > only_number(b.split(" ")[1])
          1
        else
          -1
        end
      end
    end
    return @filtered_course.insert(0,"Select A Course")
  end

  def filter_professor_by_course
    ys = params[:year]
    y = ys.split(" ")[0]
    s = ys.split(" ")[1]
    gcid = GeneralCourse.find_by(course_code: params[:gcname].split(":")[0])
    course = Course.where(general_course_id: gcid, year: y, semester: s)
    @filtered_professor = []
    course.each do |c|
      @filtered_professor.push(c.professor)
    end
    return @filtered_professor.sort
  end

  def open_edit_modal
    f_id = params[:id]
    @review = Review.find(f_id)
    respond_to do |format| 
      format.js {render 'reviews/open_edit_modal'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def filter_user_reviewed_courses
      user_reviews = current_user.reviews
      reviewed = []
      user_reviews.each do |ur|
          cid = ur.course_id
          curr_course = Course.find(cid)
          gcid = curr_course.general_course_id;
          y = curr_course.year
          s = curr_course.semester
          same_name_ys = Course.where(general_course_id: gcid, year: y, semester: s)
          # gcid = Course.find(cid).general_course_id
          # if !reviewed.include?(gcid)
          #     reviewed.push(gcid)
          # end
          if !reviewed.include?(cid)
            same_name_ys.each do |c|
              reviewed.push(c.id)
            end
            # reviewed.push(cid)
            # curr_course = Course.find(cid)
          end
      end
      return reviewed
    end

    def same_name_course(gcid,yr,smstr)
      ids = []
      courses = Course.where(general_course_id:gcid, year: yr, semester: smstr)
      courses.each do |c|
        ids.push(c.id)
      end
      return ids
    end

    # Only allow a list of trusted parameters through.
    def review_params
      begin 
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
        puts params
      rescue => e
      rescue ActiveRecord::RecordNotFound
      rescue ActiveRecord::ActiveRecordError
      rescue Exception
      end
      return params.require(:review).permit(
        :user_id,
        :title,
        :rate_up,
        :rate_down,
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

    def only_number(num_ab)
      return num_ab[0...-1].to_i
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
