class Company < ApplicationRecord
  validates :name, presence: true
  has_many :leadership_levels
end
