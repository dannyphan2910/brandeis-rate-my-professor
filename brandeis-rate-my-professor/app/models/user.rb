class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
    
    has_many :rate_ups
    has_many :rate_downs
    has_many :reviews
    has_many :enrollments
    has_many :general_courses, through: :enrollments
    has_many :messages
    has_many :conversations, foreign_key: :sender_id

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :password, presence: true, confirmation: { case_sensitive: true }

    scope :conversation_with, -> (user_id) { where.not(id: user_id).joins("INNER JOIN conversations ON conversations.sender_id = users.id OR conversations.recipient_id = users.id") }

    def self.conversations_with_ordered_most_recent user_id
        recipients = conversation_with(user_id)
        recipients.sort_by { |recipient| 
            Conversation.between(user_id, recipient.id).first.messages.any? ? 
            Conversation.between(user_id, recipient.id).first.messages.maximum('created_at') : 
            Conversation.between(user_id, recipient.id).first.created_at 
        }.reverse 
    end

    def is_admin
        if email == "admin@brandeis.edu"
            return true
        else 
            return false
        end
    end

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
