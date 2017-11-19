class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.integer :user_id
      t.integer :todo_id
      t.timestamps null: false
    end
  end
end
