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
    courses = Course.search(@search_text).order(year: :desc, semester: :asc)
    return get_hash_result courses, true
  end
  
  def get_professors
    professors = Professor.search(@search_text)
    already_chosen_ids = professors.ids
    profesors_w_courses = Professor.joins(:courses, :general_courses).where("UPPER(general_courses.course_title) LIKE ? OR UPPER(general_courses.course_code) LIKE ?", "%#{@search_text.upcase}%", "%#{@search_text.upcase}%").where.not(id: already_chosen_ids).distinct
    all_professors = professors + profesors_w_courses
    return get_hash_result all_professors, false
  end

  def get_departments
    return []
  end
end
