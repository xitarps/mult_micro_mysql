class Users::SubManagedUsersQuery < ApplicationQuery
  def initialize(depth: 2)
    @depth = depth
  end

  private

  def run
    build_query
  end

  def build_query
    build_select_users_attributes_according_to_depth +
      build_inner_joins_according_depth +
      build_where_user_id_equals_leader_id
  end

  def build_select_users_attributes_according_to_depth
    %(
      SELECT users_depth_#{@depth - 1}.*
      FROM users users_depth_0
    )
  end

  def build_inner_joins_according_depth
    (1...@depth).to_a.map { |depth| inner_join_base_query(depth) }.join
  end

  def inner_join_base_query(depth)
    %(
      INNER JOIN users users_depth_#{depth}
      ON users_depth_#{depth}.user_id = users_depth_#{depth - 1}.id
    )
  end

  def build_where_user_id_equals_leader_id
    'WHERE users_depth_0.user_id = :leader_id'
  end
end
