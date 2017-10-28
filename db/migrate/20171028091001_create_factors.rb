class CreateFactors < ActiveRecord::Migration[5.0]
  def change
    create_table :factors do |t|
      t.string :name
    end
  end
end
