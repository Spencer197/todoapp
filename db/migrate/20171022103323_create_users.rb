class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :chefname
      t.string :email
      t.timestamps null: false
      t.string :password_digest
      t.boolean :admin,    default: false
    end
  end
end
