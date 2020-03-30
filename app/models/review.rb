class CourseProfessorValidator < ActiveModel::Validator
    def validate(record)
        c_id = record.course_id
        p_id = record.professor_id
        if p_id != Course.find(c_id).professor.id
            record.errors[:base] << "Unable to find this professor teaching this course"
        end
    end
end

class Review < ApplicationRecord
    belongs_to :user
    belongs_to :course
    belongs_to :professor
    has_one :course_rating
    has_one :professor_rating

    validates :user_id, presence: true
    validates :course_id, presence: true
    validates :professor_id, presence: true
    validates_with CourseProfessorValidator

    accepts_nested_attributes_for :course_rating, :professor_rating

    scope :ordered_by_rate_up, -> { order(rate_up: :desc, rate_down: :asc) }
end


