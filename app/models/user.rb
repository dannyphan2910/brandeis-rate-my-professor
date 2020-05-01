class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
    devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
    
    has_many :rate_ups
    has_many :rate_downs
    has_many :reviews
    has_many :enrollments
    has_many :general_courses, through: :enrollments
    has_many :messages
    has_many :conversations, foreign_key: :sender_id

    has_one_attached :avatar
    validate :acceptable_image

    validates :first_name, presence: true
    validates :last_name, presence: true
    
    def self.conversation_with user_id
        users = where.not(id: user_id)
        users.select { |recipient| Conversation.between(user_id, recipient.id).exists? }
    end

    def self.conversations_with_ordered_most_recent user_id
        recipients = conversation_with(user_id)
        recipients.sort_by { |recipient| 
            Conversation.between(user_id, recipient.id).first.messages.any? ? 
            Conversation.between(user_id, recipient.id).first.messages.maximum('created_at') : 
            Conversation.between(user_id, recipient.id).first.created_at 
        }.reverse 
    end

    def is_admin_user
        if email == "admin@brandeis.edu"
            return true
        else 
            return is_admin
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

    def self.from_omniauth(access_token)
        data = access_token.info
        user = User.where(email: data['email']).first
        user
    end

    def acceptable_image
        return unless avatar.attached?

        unless avatar.byte_size <= 1.megabyte
            errors.add(:avatar, "Image is too big")
        end
      
        acceptable_types = ["image/jpeg", "image/png", "image/jpg"]
        unless acceptable_types.include?(avatar.content_type)
            errors.add(:avatar, "Image must be a JPEG, JPG, or PNG")
        end
    end
end
