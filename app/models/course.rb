class Course < ApplicationRecord
    has_many :gets
    has_many :reviews, through: :gets
    belongs_to :professor
end
