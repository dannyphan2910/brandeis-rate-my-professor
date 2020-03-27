class Course < ApplicationRecord
    has_many :reviews
    belongs_to :professor
    has_many :course_ratings, through: :reviews

    def show_course_info
        "#{course_code}. #{course_title}"
    end
end
