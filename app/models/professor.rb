class Professor < ApplicationRecord
    has_many :reviews
    has_many :courses
    has_many :professor_ratings, through: :reviews
    has_many :general_courses, through: :courses
    belongs_to :department

    scope :search, -> (term) { where("UPPER(prof_first_name) LIKE ? OR UPPER(prof_last_name) LIKE ?", "%#{term.upcase}%", "%#{term.upcase}%").order("prof_first_name, prof_last_name") }

    def show_name
        "#{prof_first_name} #{prof_last_name}"
    end

    # Calculates the average of each category for every rating
    def get_average
        record_hash = {}
        record_hash['avg_cat1'] = professor_ratings.average(:cat1) || 0
        record_hash['avg_cat2'] = professor_ratings.average(:cat2) || 0
        record_hash['avg_cat3'] = professor_ratings.average(:cat3) || 0
        record_hash['avg_cat4'] = professor_ratings.average(:cat4) || 0
        record_hash['avg_cat5'] = professor_ratings.average(:cat5) || 0
        record_hash['total_reviews'] = professor_ratings.length
        return record_hash
    end
end
