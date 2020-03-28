class Course < ApplicationRecord
    has_many :reviews
    belongs_to :professor
    has_many :course_ratings, through: :reviews

    def show_course_info
        "#{course_code}. #{course_title}"
    end

    scope :search, -> (term) { where("UPPER(course_title) LIKE ? OR UPPER(course_code) LIKE ?", "%#{term.upcase}%", "%#{term.upcase}%") if !term.blank? }
    scope :all_courses, -> { select(:course_code, :course_title).group(:course_code, :course_title).order(:course_code) }
end
