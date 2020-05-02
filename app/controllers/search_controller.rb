class SearchController < ApplicationController
  def search_result
    @search_text = params[:search_text]
    @filter = params[:filter]
    if !@search_text.blank?
      do_search
    end

    if request.xhr?
      render 'filter.js.erb'
    end
  end

  def do_search
      if params[:filter_general_courses] && params[:filter_general_courses] === "true"
        @courses = get_general_courses unless (@filter == "professor" || @filter == "department")
      else
        @courses = get_courses unless (@filter == "professor" || @filter == "department")
      end

      @professors = get_professors unless (@filter == "course" || @filter == "department")
      @departments = get_departments unless (@filter == "professor" || @filter == "course")
      @total_result = (@courses.nil? ? 0 : @courses.length) + (@professors.nil? ? 0 : @professors.length) + (@department.nil? ? 0 : @department.length)
  end

  def get_general_courses
    courses = GeneralCourse.search(@search_text)
    return get_hash_result courses, true
  end

  def get_courses
    courses = Course.search(@search_text).order(year: :desc, semester: :asc)
    return get_hash_result courses, true
  end
  
  def get_professors
    professors = Professor.search(@search_text)
    already_chosen_ids = professors.ids
    profesors_w_courses = Professor.where.not(id: already_chosen_ids).joins(:courses, :general_courses).where("UPPER(general_courses.course_title) LIKE ? OR UPPER(general_courses.course_code) LIKE ?", "%#{@search_text.upcase}%", "%#{@search_text.upcase}%").distinct
    all_professors = professors + profesors_w_courses
    return get_hash_result all_professors, false
  end

  def get_departments
    departments_by_name = Department.search(@search_text) 
    already_chosen_ids = departments_by_name.ids
    departments_by_prof = Department.where.not(id: already_chosen_ids).joins(:professors).where("UPPER(professors.prof_first_name) LIKE ? OR UPPER(professors.prof_last_name) LIKE ?", "%#{@search_text.upcase}%", "%#{@search_text.upcase}%").distinct
    already_chosen_ids += departments_by_prof.ids
    departments_by_courses = Department.all.select { |department| department.general_courses.where("UPPER(general_courses.course_title) LIKE ? OR UPPER(general_courses.course_code) LIKE ?", "%#{@search_text.upcase}%", "%#{@search_text.upcase}%").length > 0 }
    all_departments = departments_by_name + departments_by_prof + departments_by_courses
    all_departments = all_departments.sort_by { |dept| dept.dept_name }
    return get_dept_result all_departments
  end
end
