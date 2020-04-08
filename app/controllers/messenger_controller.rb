class MessengerController < ApplicationController
  before_action :login_required
  skip_before_action :verify_authenticity_token

  def show
    session[:conversations] ||= []
    @users = User.conversation_with(current_user.id).order("conversations.created_at DESC")
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end
end
