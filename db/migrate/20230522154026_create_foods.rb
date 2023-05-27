class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.references :user, index: true, null: false, foreign_key: {to_table: :users}
      t.string :name
      t.string :measurement_unit
      t.integer :price
      t.integer :quantity
      t.timestamps
    end
  end
end
