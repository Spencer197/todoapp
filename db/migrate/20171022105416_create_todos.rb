class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
      t.integer :user_id
    end
  end
end
