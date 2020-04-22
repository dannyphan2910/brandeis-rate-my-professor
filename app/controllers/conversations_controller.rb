class ConversationsController < ApplicationController
  before_action :login_required
  skip_before_action :verify_authenticity_token
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    # get the conversation between the current user and the user passed in through the parameter
    @conversation = Conversation.get(current_user.id, params[:user_id])

    # if in the session there is no added conversation_id yet, we’ll add it
    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    session[:conversation] = nil
    @conversation.destroy
    
    @users = User.conversations_with_ordered_most_recent(current_user.id)

    respond_to do |format|
      format.js { }
    end
  end

  private
    def add_to_conversations
      session[:conversation] = @conversation.id
    end

    def conversated?
      session[:conversation] == @conversation.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:recipient_id, :sender_id)
    end
end
