class TodoFactor < ApplicationRecord
  belongs_to :factor 
  belongs_to :todo
end