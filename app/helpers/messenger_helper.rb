module MessengerHelper
    
  def find_conversation_with recipient_id
    if logged_in?
      Conversation.between(current_user.id, recipient_id).first
    end
  end

  def unread_messages conversation_id, recipient_id
    Message.not_read(conversation_id, recipient_id).count
  end

  def new_conversation_suggestion conversation
    @new_conversation_suggestion = {
      "badge badge-pill badge-warning" => "Hi #{conversation.opposed_user(current_user).first_name}!",
      "badge badge-pill badge-success d-none d-lg-block d-xl-block" => "Hello! How are you today?",
      "badge badge-pill badge-info d-none d-lg-block d-xl-block" => "Hi there! How’s it going?",
      "badge badge-pill badge-secondary d-none d-lg-block d-xl-block" => "Hello. I am #{current_user.first_name}",
      "badge badge-pill badge-danger d-none d-lg-block d-xl-block" => "Hey #{conversation.opposed_user(current_user).first_name}! Can we have a talk?"
    }
  end
end
