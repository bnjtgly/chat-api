# frozen_string_literal: true

class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.where(id: current_user.id).first
    @chatrooms = @user.chatrooms.uniq
    get_participants @chatrooms if @chatrooms
  end

  def show
    @user = User.where(id: current_user.id).first
    chatroom = @user.chatrooms.find(params[:id])

    render json: ChatroomSerializer.new(chatroom)
  end

  # POST /chatrooms
  def create
    interact = CreateChatroom.call(data: params, current_user: current_user)

    if interact.success?
      @chatroom = interact.chatroom
    else
      render json: { error: interact.error }, status: 422
    end
  end

  private

  def set_participants_name(participants)
    User.find(participants).pluck(:first_name, :last_name).join(' ')
  end

  def get_participants(conversations)
    conversations.map do |conversation|
      conversation.title = set_participants_name(conversation.participants - [current_user.id])
    end
  end
end