json.user do
  json.id @user.id
  json.name @user.name.to_s
  json.email @user.email
  json.contact_number @user.contact_number
end