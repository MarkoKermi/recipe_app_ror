class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: "recipe", foreign_key: "recipe_id"
  belongs_to :food, class_name: "food", foreign_key: "food_id"

  validates :quantity, numericality: { greater_than: 0 }
end
