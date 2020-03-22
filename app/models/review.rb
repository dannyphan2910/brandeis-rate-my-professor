class Review < ApplicationRecord
    belongs_to :user
    belongs_to :course
    has_one :course_rating
    has_one :professor_rating
    validates :user_id, presence: true
    validates :course_id, presence: true
    accepts_nested_attributes_for :course_rating, :professor_rating
end
