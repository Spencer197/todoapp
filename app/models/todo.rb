#This model provides the getters and setters for the name (title) and description attributes.
class Todo < ApplicationRecord#differs from Rails 4: < ActiveRecord::Base
  validates :name, presence: true# Ensures that name and description are present in Todo form in order to save.
  validates :description, presence: true, length: { minimum: 5, maximum: 10000 }
  belongs_to :user#Asserts that todos belong to User class.
  validates :user_id, presence: true#Asserts that user-id must be present when creating a todo.
  default_scope -> { order(updated_at: :desc) }#Arranges recipes in order from newest to oldest.
  has_many :todo_factors
  has_many :factors, through: :todo_factors
end