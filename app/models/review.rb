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
>>>>>>> 369d2edb21195ca1d0cf81c0c2ae9f7e14603438
end
