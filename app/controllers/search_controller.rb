class SearchController < ApplicationController
  def search_result
    @search_text = params[:search_text]
    @filter = params[:filter]
    if !@search_text.blank?
      do_search
    end
  end

  def do_search
      @courses = get_courses unless (@filter == "professor" || @filter == "department")
      @professors = get_professors unless (@filter == "course" || @filter == "department")
      @departments = get_departments unless (@filter == "professor" || @filter == "course")
      @total_result = (@courses.nil? ? 0 : @courses.length) + (@professors.nil? ? 0 : @professors.length) + (@department.nil? ? 0 : @department.length)
  end

  def get_courses
    courses = Course.where("UPPER(course_title) LIKE ? OR UPPER(course_code) LIKE ?", "%#{@search_text.upcase}%", "%#{@search_text.upcase}%").order(year: :desc, semester: :asc).distinct
    return get_hash_result courses, true
  end
  
  def get_professors
    professors = Professor.where("UPPER(prof_first_name) LIKE ? OR UPPER(prof_last_name) LIKE ?", "%#{@search_text.upcase}%", "%#{@search_text.upcase}%").distinct
    already_chosen_ids = professors.ids
    profesors_w_courses = Professor.where.not(id: already_chosen_ids).joins(:courses).where("UPPER(courses.course_title) LIKE ? OR UPPER(courses.course_code) LIKE ?", "%#{@search_text.upcase}%", "%#{@search_text.upcase}%").distinct
    all_professors = professors + profesors_w_courses
    return get_hash_result all_professors, false
  end

  def get_departments
    return []
  end
end
