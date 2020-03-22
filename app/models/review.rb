class Review < ApplicationRecord
    has_one :course_rating
    has_one :professor_rating
    belongs_to :user
    has_many :gets
    has_many :courses, through: :gets

    accepts_nested_attributes_for :course_rating, :professor_rating
end
