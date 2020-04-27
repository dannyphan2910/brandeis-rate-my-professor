class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  has_many_attached :attachments
  validate :acceptable_attachments

  # executes a code or a method passed in params when a record has been created and successfully inserted to a database – when SQL commit is done
  after_create_commit { MessageBroadcastJob.perform_later(self) }

  scope :not_read, -> (conversation_id, user_id) { where(conversation_id: conversation_id, user_id: user_id, is_read: nil) }

  def acceptable_attachments
    return unless attachments.attached?

    if attachments.length() > 2
      errors.add(:attachments, "Only 2 attachments per message")
    end

    attachments.each do |attachment|
      unless avatar.byte_size <= 1.megabyte
        errors.add(:attachments, "Image is too big")
      end
  
      acceptable_types = ["image/jpeg", "image/png", "image/jpg"]
      unless acceptable_types.include?(avatar.content_type)
        errors.add(:attachments, "Image must be a JPEG, JPG, or PNG")
      end
    end
end
end
