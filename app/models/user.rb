class User < ApplicationRecord
    include ActiveModel::SecurePassword
    has_secure_password
    
    has_many :rate_ups
    has_many :rate_downs
    has_many :reviews
    has_many :enrollments
    has_many :general_courses, through: :enrollments

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :password, presence: true, confirmation: { case_sensitive: true }

    def show_full_name
        "#{first_name} #{last_name}"
    end

    def has_rated_up review_id
        RateUp.exists?(user_id: id, review_id: review_id)
    end

    def has_rated_down review_id
        RateDown.exists?(user_id: id, review_id: review_id)
    end

    def rated_up_reviews
        Review.joins(:rate_ups).where('rate_ups.user_id = ?', "#{id}")
    end

    def rated_up_reviews
        Review.joins(:rate_downs).where('rate_downs.user_id = ?', "#{id}")
    end
end
