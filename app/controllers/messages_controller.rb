class MessagesController < ApplicationController

  def index
    @messages = Message.list_all_messages
  end

  def new
    @message = Message.new
  end

  def create
    message = Message.create_new_message params[:message][:user_id], params[:message][:content]

    if message == true
      flash[:message] = "New message created"
      redirect_to messages_path
    else
      flash[:warning] = "Failed to save message"
      redirect_to new_message_path
    end
  end

  def destroy
    Message.delete_message(params[:id])
    redirect_to messages_path
  end

  def show
    @message = Message.where(mid: params[:id])
  end

end
