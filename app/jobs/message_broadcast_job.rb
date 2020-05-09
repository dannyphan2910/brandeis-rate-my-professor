class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = message.user
    recipient = message.conversation.opposed_user(sender)

    broadcast_to_sender(sender, recipient, message)
    broadcast_to_recipient(sender, recipient, message)
  end

  private

  def broadcast_to_sender(sender, recipient, message)
    ActionCable.server.broadcast(
      "conversations-#{sender.id}",
      message: render_message(message, sender),
      conversation_id: message.conversation_id,
      recipient: recipient.id
    )
  end

  def broadcast_to_recipient(sender, recipient, message)
    ActionCable.server.broadcast(
      "conversations-#{recipient.id}",
      window: render_window(message.conversation, recipient),
      message: render_message(message, recipient),
      conversation_id: message.conversation_id,
      sender: sender.id,
      sender_name: sender.show_full_name
    )
  end

  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end

  def render_window(conversation, user)
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
  end
end
