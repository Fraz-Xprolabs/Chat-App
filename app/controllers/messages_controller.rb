class MessagesController < ApplicationController
  before_action :set_message, only: %i[edit update destroy]

  def index
    @messages = Message.order(created_at: :asc)
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.turbo_stream
      end                     
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    render turbo_stream: turbo_stream.replace(
      @message,
      partial: "messages/form",
      locals: { message: @message }
    )
  end


  def update
    if @message.update(message_params)
      respond_to do |format|
        format.turbo_stream 
        format.html { redirect_to root_path }
      end
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:username, :content)
  end
end
