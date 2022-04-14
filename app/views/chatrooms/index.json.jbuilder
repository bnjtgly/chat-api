json.data do
  json.array! @chatrooms.each do |data|
    json.id data.id
    json.title data.title
    json.participants data.participants
  end
end
