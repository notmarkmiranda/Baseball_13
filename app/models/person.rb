class Person < ApplicationRecord
  has_one :team

  validates :name, presence: true, uniqueness: true
end
