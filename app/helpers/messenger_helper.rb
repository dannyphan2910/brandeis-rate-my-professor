module MessengerHelper
    
  def find_conversation sender_id, conversation_id
    Conversation.between(sender_id, conversation_id).ids.first
  end
end
