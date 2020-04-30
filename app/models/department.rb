class Department < ApplicationRecord
    has_many :professors
    has_many :courses, -> { distinct }, through: :professors
    has_many :general_courses, -> { distinct }, through: :professors
end
