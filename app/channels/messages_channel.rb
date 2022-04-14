class MessagesChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Chatroom.find(params[:chatroom])
    stream_for chatroom
  end

  def unsubscribed; end
end
