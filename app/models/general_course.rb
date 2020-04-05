class GeneralCourse < ApplicationRecord
    has_many :courses
    has_many :professors, -> { distinct }, through: :courses
    has_many :reviews, -> { distinct }, through: :courses
    has_many :course_ratings, -> { distinct }, through: :courses
    has_many :enrollments
    has_many :users, through: :enrollments

    scope :search, -> (term) { where("UPPER(course_code) LIKE ? OR UPPER(course_title) LIKE ?", "%#{term.upcase}%", "%#{term.upcase}%").order("course_code ASC") }

    def self.search_all term
        courses = self.search term
        result = []
        courses.each { |course| course.courses.each { |c| result.push(c) } }
        result
    end

    def self.not_taken_by_user user_id
        taken = Enrollment.where(user_id: user_id).select(:general_course_id)
        GeneralCourse.where.not(id: taken)
    end

    def show_course_info
        "#{course_code}: #{course_title}"
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
