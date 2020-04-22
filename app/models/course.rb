class Course < ApplicationRecord
    has_many :reviews
    has_many :course_ratings, through: :reviews
    belongs_to :professor
    belongs_to :general_course
    delegate :course_code, :course_title, :course_description, to: :general_course

    scope :search, -> (term) { joins(:general_course).where("UPPER(general_courses.course_code) LIKE ? OR UPPER(general_courses.course_title) LIKE ?", "%#{term.upcase}%", "%#{term.upcase}%").order("general_courses.course_code ASC") }

    def show_course_info
        "#{course_code}: #{course_title}"
    end

    def show_course_offering
        "#{semester} #{year}"
    end

    def admin_course_label
        "#{semester} #{year} #{course_code}"
    end

    # Calculates the average of each category for every rating
    def get_average
        record_hash = {}
        record_hash['avg_cat1'] = course_ratings.average(:cat1) || 0
        record_hash['avg_cat2'] = course_ratings.average(:cat2) || 0
        record_hash['avg_cat3'] = course_ratings.average(:cat3) || 0
        record_hash['avg_cat4'] = course_ratings.average(:cat4) || 0
        record_hash['avg_cat5'] = course_ratings.average(:cat5) || 0
        record_hash['total_reviews'] = course_ratings.length
        return record_hash
    end
end
