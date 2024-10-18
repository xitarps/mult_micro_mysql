class LeadershipLevel < ApplicationRecord
  belongs_to :company
  has_many :users, dependent: :nullify
  validates :level, presence: true, uniqueness: { scope: [:level, :company_id] }
end
