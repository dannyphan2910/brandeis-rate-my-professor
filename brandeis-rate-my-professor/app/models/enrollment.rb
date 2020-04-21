class Enrollment < ApplicationRecord
    belongs_to :user
    belongs_to :general_course
    validates :user_id, uniqueness: { scope: [:general_course_id] }
end
