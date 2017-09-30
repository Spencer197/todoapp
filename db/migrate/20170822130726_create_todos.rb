class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.text :description
      t.timestamps #automatically adds created_at & updated_at timesptamps to the table.
    end
  end
end
