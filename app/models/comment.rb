class Comment < ApplicationRecord
  validates :description, presence: true, length: { minimum: 4, maximum: 200 }
  belongs_to :user
  belongs_to :todo 
  validates :user_id, presence: true
  validates :todo_id, presence: true
  default_scope -> { order(updated_at: :desc)}
end