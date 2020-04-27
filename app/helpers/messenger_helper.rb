module MessengerHelper
    
  def find_conversation_with recipient_id
    if logged_in?
      Conversation.between(current_user.id, recipient_id).first
    end
  end

  def unread_messages conversation_id, recipient_id
    Message.not_read(conversation_id, recipient_id).count
  end
end
