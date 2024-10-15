class Users::SubManagedUsersQuery
  def self.call
   %(
      SELECT sub_users.* 
      FROM users main_users 
      INNER JOIN users sub_users ON sub_users.user_id = main_users.id
      WHERE main_users.user_id = :leader_id
    )
  end
end