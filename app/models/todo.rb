class Todo < ApplicationRecord#differs from Rails 4: < ActiveRecord::Base
  validates :name, presence: true# Ensures that name and description are present in Todo form in order to save.
  validates :description, presence: true
end