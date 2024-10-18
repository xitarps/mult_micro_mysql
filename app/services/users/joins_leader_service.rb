class Users::JoinsLeaderService < ApplicationService
  def initialize(user: nil, leader: nil)
    @user = user
    @leader = leader

    same_user_types_validation
    same_company_validation
  end

  private

  def run
    raise 'Leader must be in the hierarchy(level can\'t be nil)' if @leader.level.nil?
    raise 'User can\'t be on equal or higher level than the leader' if @user.level && @user.level <= @leader.level

    @user_new_level = @leader.level + 1
    @user.update(level: @user_new_level, leader: @leader)
    @user.leadership_level.users.delete(@user) unless @user.leadership_level.nil?

    user_target_leadership_level = LeadershipLevel.find_or_create_by(level: @user_new_level, company: @leader.company)
    user_target_leadership_level.users << @user

    @user
  end

  def same_company_validation
    message = 'Either User and Leader must be from the same company'
    raise message unless @user.company_id == @leader.company_id
  end

  def same_user_types_validation
    message = "Either User and Leader must be 'User' type, got: #{@user.class} and #{@leader.class}"
    raise message unless [@user, @leader].all? { |object| object.is_a?(User) }
  end
end
