require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'tobby', email: 'tobby@example.com', password: 'samuel') }
  let(:food) { Food.create(name: 'beans', quantity: 10, measurement_unit: 'grams', price: 50, user_id: user.id) }
  let(:recipe) do
    Recipe.create(name: 'salt', preparation_time: 2, cooking_time: 2, description: 'i am cooking', user_id: user.id,
                  public: true)
  end
  let(:recipe_food) { RecipeFood.new(quantity: 20, food_id: food.id, recipe_id: recipe.id) }

  describe 'Recipe food create' do
    it 'expect Recipe_food to be created' do
      expect(recipe_food).to be_valid
    end

    it 'expect Recipe_food to not be valid when food_id is null' do
      recipe_food.food_id = nil
      expect(recipe_food).to_not be_valid
    end

    it 'expect Recipe_food to not be valid when recipe_id is null' do
      recipe_food.recipe_id = nil
      expect(recipe_food).to_not be_valid
    end

    it 'expect Recipe_food to not be valid when quantity less than 0' do
      recipe_food.quantity = -1
      expect(recipe_food).to_not be_valid
    end

    it 'expect Recipe_food to not be valid when quantity is string' do
      recipe_food.quantity = 'www'
      expect(recipe_food).to_not be_valid
    end
  end
end
