class ChatroomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :participants, :users, :messages
  attribute :users do |room|
    UserSerializer.new(room.users.uniq)
  end
end
