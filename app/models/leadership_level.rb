class LeadershipLevel < ApplicationRecord
  belongs_to :company
  validates :level, presence: true, uniqueness: { scope: [:level, :company_id] }
end
