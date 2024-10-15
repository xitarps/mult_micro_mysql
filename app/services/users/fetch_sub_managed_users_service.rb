class Users::FetchSubManagedUsersService < ApplicationService
  def initialize(leader_id: nil)
    @leader_id = leader_id
  end

  private

  def run
    perform_query
    convert_result_items_to_instances
  end

  def perform_query
    @result = ActiveRecord::Base.connection.execute(
      ApplicationRecord.sanitize_sql_array(
        [Users::SubManagedUsersQuery.call, leader_id: @leader_id]
      )
    )
  end

  def convert_result_items_to_instances
    @result = symbolize_hash

    @result.map! do |hash|
      instanciate_object(hash)
    end
  end

  def symbolize_hash
    JSON.parse(@result.to_json, symbolize_names: true)
  end

  def instanciate_object(hash)
    object = User.new(hash)
    object.instance_variable_set(:@new_record, false)
    object
  end
end
