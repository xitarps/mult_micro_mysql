class User < ApplicationRecord
  belongs_to :company

  belongs_to :leader, class_name: 'User', optional: true, foreign_key: :user_id
  belongs_to :leadership_level, optional: true

  has_many :managed_users, class_name: 'User', foreign_key: :user_id

  validates :name, presence: true
end
