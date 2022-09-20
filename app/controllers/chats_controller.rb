class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show update destroy ]

  # GET /chats
  def index
    @chats = Chat.all

    render json: @chats.as_json({index: true})
  end

  # GET /chats/1
  def show
    render json: @chat.as_json({show: true})
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: @chat.as_json({create: true}), status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat.as_json({update: true})
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  def chats_by_username
    @chats = Chat.where(username: params[:username], is_read: false).where('expiration_date > ?', DateTime.now)

    render json: @chats.as_json({username: true})
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:username, :text, :timeout, :is_read)
    end
end
