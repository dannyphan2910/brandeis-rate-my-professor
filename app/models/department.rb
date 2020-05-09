class Department < ApplicationRecord
    has_many :professors
    has_many :courses, -> { distinct }, through: :professors
    has_many :general_courses, -> { distinct }, through: :professors

    scope :search, -> (term) { where("UPPER(dept_name) LIKE ?", "%#{term.upcase}%").order(:dept_name) }

    def get_info
        record_hash = {}
        record_hash['num_of_profs'] = professors.length || 0
        record_hash['num_of_courses'] = general_courses.length || 0

        max_prof = professors.sort_by { |prof| prof.professor_ratings.length }.last 
        max_course = general_courses.sort_by { |gc| gc.course_ratings.length }.last

        record_hash['max_prof_id'] = max_prof.id
        record_hash['max_prof_name'] = max_prof.show_name

        record_hash['max_course_id'] = max_course.id
        record_hash['max_course_name'] = max_course.show_course_info
        
        record_hash
    end
end
