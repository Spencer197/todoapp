class CreateTodoFactors < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_factors do |t|
      t.integer :todo_id
      t.integer :factor_id
    end
  end
end
