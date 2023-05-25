require 'rails_helper'

RSpec.describe 'Recipe', type: :system do
  describe 'shoppinglist' do
    before :each do
      visit new_user_session_path
      @user = User.create(name: 'tobby', email: 'tobby2@example.com', password: 'ayomide0803',
                          confirmation_token: 'Mvn7VM3szs3CxwrKA6H', confirmed_at: '2023-05-22 17:16:58.291555',
                          updated_at: '2023-05-22 17:16:58.291555', created_at: '2023-05-22 17:16:58.291555')
      @recipe = Recipe.create(name: 'fish', cooking_time: 10, description: 'we are cooking', preparation_time: 50,
                              user_id: @user.id, public: false)
      @food = Food.create(name: 'beans', quantity: 10, measurement_unit: 'grams', price: 50, user_id: @user.id)
      @foodtwo = Food.create(name: 'potatoes', quantity: 20, measurement_unit: 'grams', price: 100, user_id: @user.id)
      @foodthree = Food.create(name: 'tacos', quantity: 30, measurement_unit: 'grams', price: 200, user_id: @user.id)
      @recipe_food = RecipeFood.create(food_id: @food.id, quantity: 20, recipe_id: @recipe.id)
      @recipe_foodtwo = RecipeFood.create(food_id: @foodtwo.id, quantity: 30, recipe_id: @recipe.id)
      @recipe_foodthree = RecipeFood.create(food_id: @foodthree.id, quantity: 40, recipe_id: @recipe.id)

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on 'Log in'
      click_on 'Recipe'
      click_on @recipe.name
      click_on 'generate list'
    end

    it 'should have shopping list' do
      expect(page).to have_content('Shopping List')
    end

    it 'should have Amount of food to buy' do
      expect(page).to have_content('Amount of food to buy')
    end

    it 'should have Total value of food needed' do
      expect(page).to have_content('Total value of food needed')
    end

    it 'should contain total food the recipe have' do
      expect(page).to have_content(@recipe.foods.length)
    end

    it 'should contain total amount of food to buy' do
      expect(page).to have_content("$#{@recipe.foods.sum(:price)}")
    end

    it 'have all foods in the receipes' do
      @recipe.foods.each do |e|
        expect(page).to have_content e.name.capitalize
      end
    end

    it 'have all foods in the receipes' do
      @recipe.recipe_foods.each do |e|
        expect(page).to have_content e.food.quantity
      end
    end

    it 'have all foods in the receipes' do
      @recipe.recipe_foods.each do |e|
        expect(page).to have_content("$#{e.food.price * e.quantity}")
      end
    end
  end
end
