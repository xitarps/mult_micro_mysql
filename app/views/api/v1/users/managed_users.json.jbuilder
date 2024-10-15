json.data do
  json.users @users do |user|
    json.id       user.id
    json.name     user.name
  end
end
