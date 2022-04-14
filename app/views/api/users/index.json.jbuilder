json.user do
  json.user_id @user.id
  json.email @user.email
  json.first_name @user.first_name
  json.last_name @user.last_name
  json.complete_name @user.complete_name
end