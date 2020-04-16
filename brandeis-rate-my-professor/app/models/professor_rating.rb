class ProfessorRating < ApplicationRecord
    belongs_to :review
    validates :strength, presence: true
    validates :improvement, presence: true
end
