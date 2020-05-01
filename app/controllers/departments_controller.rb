class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @filter_courses = [
      ["By Course Title ASC", "courses_asc"],
      ["By Course Title DESC", "courses_desc"]
    ]
    @filter_professors = [
      ["By First Name ASC", "professors_first_asc"],
      ["By First Name DESC", "professors_first_desc"],
      ["By Last Name ASC", "professors_last_asc"],
      ["By Last Name DESC", "professors_last_desc"]
    ]

    @courses_filter = params[:filter_courses] || "courses_asc"
    @professors_filter = params[:filter_professors] || "professors_first_asc"

    case @courses_filter
      when "courses_asc"
        @courses = @department.general_courses.order(:course_code, :course_title)
      when "courses_desc"
        @courses = @department.general_courses.order(course_code: :desc, course_title: :desc)
    end
    
    case @professors_filter
      when "professors_first_asc"
        @professors = @department.professors.order(:prof_first_name)
      when "professors_first_desc"
        @professors = @department.professors.order(prof_first_name: :desc)
      when "professors_last_asc"
        @professors = @department.professors.order(:prof_last_name)
      when "professors_last_desc"
        @professors = @department.professors.order(prof_last_name: :desc)
    end
    
    if request.xhr?
      render 'show.js.erb'
    end
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def department_params
      params.require(:department).permit(:dept_name)
    end
end
