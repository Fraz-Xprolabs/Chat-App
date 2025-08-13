class MessagesController < ApplicationController
  def index
    @messages = Message.order(created_at: :asc)
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to root_path}
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:username, :content)
  end
end
