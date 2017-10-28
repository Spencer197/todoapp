class Factor < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates_uniqueness_of :name
  has_many :todo_factors
  has_many :todos, through: :todo_factors
end