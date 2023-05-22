class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.references :user, index: true, null: false, foreign_key:{to_table: :users}
      t.integer :preparation_time
      t.integer :cooking_time
      t.text :description
      t.boolean :public
      t.timestamps
    end
  end
end
