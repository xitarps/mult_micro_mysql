class User < ApplicationRecord
  belongs_to :company

  belongs_to :leader, class_name: 'User', optional: true, foreign_key: :user_id
  belongs_to :leadership_level, optional: true

  has_many :managed_users, class_name: 'User', foreign_key: :user_id, dependent: :nullify

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: [:email, :company_id] }
  before_destroy :handle_managed_users_leaderships

  private

  def handle_managed_users_leaderships
    # TODO: - double check with P.O if this is the correct business logic
    relocate_managed_users_with_upper_leader
  end

  def relocate_managed_users_with_upper_leader
    managed_users.each do |user|
      # TODO: - Maybe call a Job/Sidekiq here? or set leaders nil ?
      Users::JoinsLeaderService.call(user: user, leader: leader)
    end
  end
end
