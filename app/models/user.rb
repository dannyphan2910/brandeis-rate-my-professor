class User < ApplicationRecord
    include ActiveModel::SecurePassword
    has_secure_password
    
    has_many :reviews

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :password, presence: true, confirmation: { case_sensitive: true }
end
