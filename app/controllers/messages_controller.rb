class MessagesController < ApplicationController

  def index
    @messages = Message.list_all_messages
  end

  def new
  end

  def create
    Message.create_new_message params[:uid], params[:content]
    redirect_to messages_path
  end

  def destroy
    Message.delete_message(params[:id])
    redirect_to messages_path
  end

  def show
    @message = Message.where(mid: params[:id])
  end

end
