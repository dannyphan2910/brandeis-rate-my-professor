class Review < ApplicationRecord
    belongs_to :user
<<<<<<< HEAD
    has_many :gets
    has_many :courses, through: :gets
    belongs_to :review_form
=======
    belongs_to :course
    has_one :course_rating
    has_one :professor_rating
>>>>>>> home-page
end
