class Company < ApplicationRecord
  has_many :users
  has_many :leadership_levels
 
  validates :name, presence: true
  validate :top_level_user_presence
  accepts_nested_attributes_for :users, allow_destroy: true

  after_commit :generate_top_level_with_top_user, on: :create

  private

  def top_level_user_presence
    errors.add('User association', 'must exists to create a company') if users.empty?
    return errors.add('User association', 'must have a top level user') if new_record? && !users.any?{|user| user.level == 0 }

    errors.add('User association', 'must have a top level user') if !new_record? && !users.where(users: { level: 0 }).limit(1)
  end

  def generate_top_level_with_top_user
    level_zero = LeadershipLevel.create(company: self, level: 0)
    level_zero.users << users.select{ |user| user.level == 0 }&.first
  end
end
