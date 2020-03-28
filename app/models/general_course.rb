class GeneralCourse < ApplicationRecord
    has_many :courses
    has_many :professors, -> { distinct }, through: :courses
    has_many :reviews, -> { distinct }, through: :courses
    has_many :course_ratings, -> { distinct }, through: :courses

    scope :search, -> (term) { where("UPPER(course_code) LIKE ? OR UPPER(course_title) LIKE ?", "%#{term.upcase}%", "%#{term.upcase}%").order("course_code ASC") }

    def self.search_all term
        courses = self.search term
        result = []
        courses.each { |course| course.courses.each { |c| result.push(c) } }
        result
    end
end
