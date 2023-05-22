class Food < ApplicationRecord
  belongs_to :user, class_name: "user", foreign_key: "user_id"
  has_many :recipe_foods, class_name: "recipe_food", foreign_key: "food_id"

  validates :name, presence: true 
  validates :measurement_unit, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than: 0 }
end
