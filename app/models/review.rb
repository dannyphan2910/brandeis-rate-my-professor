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

    has_many :rate_ups
    has_many :rate_downs

    validates :user_id, presence: true
    validates :course_id, presence: true
    validates :professor_id, presence: true
    validates_with CourseProfessorValidator
    validates :title, presence: true
    
    accepts_nested_attributes_for :course_rating, :professor_rating

    scope :ordered_by_rate_up, -> { all.sort_by(&:rate_up).reverse }
    def course_review
        cr = CourseRating.find(self.id)
        return "Content: #{cr.cat1}, Participation: #{cr.cat2}, Workload: #{cr.cat3}, Testing: #{cr.cat4}, Grading: #{cr.cat5}, Comment:#{cr.content}"
    end
    
    def professor_review
        pr = ProfessorRating.find(self.id)
        return "Delivery: #{pr.cat1}, Accessibility: #{pr.cat2}, Expertise: #{pr.cat3}, Expectations: #{pr.cat4}, Preparedness: #{pr.cat5}, Strength: #{pr.strength}, Improvement: #{pr.improvement}"
    end

    def rate_up
        rate_ups.length
    end

    def rate_down
        rate_downs.length
    end
end


