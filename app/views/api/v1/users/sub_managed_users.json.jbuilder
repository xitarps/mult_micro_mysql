json.data do
  json.users @users do |user|
    json.partial! 'api/v1/users/user', user: user

  end
end
