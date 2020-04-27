class MessengerController < ApplicationController
  before_action :login_required
  skip_before_action :verify_authenticity_token

  # GET /messenger_home
  def show
    @users = User.conversations_with_ordered_most_recent(current_user.id)
    
  end

  # POST /message/:id
  def message
    @user_id = params[:id]
    if @user_id != current_user.id
      convo = Conversation.get(current_user.id, @user_id)
      session[:conversation] = convo.id
      respond_to do |format|
        flash[:recipient_id] = @user_id
        format.html { redirect_to '/messenger_home' }
      end
    end
  end

end
