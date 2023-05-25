require 'rails_helper'

RSpec.describe 'recipe', type: :system do
  describe 'recipe' do
    before :each do
      visit new_user_session_path
      @user = User.create(name: 'tobby', email: 'tobby2@example.com', password: 'ayomide0803',
                          confirmation_token: 'Mvn7VM3szs3CxwrKA6H', confirmed_at: '2023-05-22 17:16:58.291555',
                          updated_at: '2023-05-22 17:16:58.291555', created_at: '2023-05-22 17:16:58.291555')
      @recipe = Recipe.create(name: 'Recipe 1', preparation_time: 1, cooking_time: 2, description: 'text',
                              public: true, user_id: @user.id)
      @recipetwo = Recipe.create(name: 'Recipe 2', preparation_time: 2, cooking_time: 4, description: 'text 2',
                                 public: true, user_id: @user.id)
      @recipethree = Recipe.create(name: 'Recipe 3', preparation_time: 3, cooking_time: 5, description: 'text 3',
                                   public: true, user_id: @user.id)
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on 'Log in'
      click_on 'Recipe'
    end

    it 'have content, Here is the list of all recipe in your catalogue' do
      expect(page).to have_content 'Here is a list of my recipes'
    end

    it 'should display the first recipe created by the user' do
      expect(page).to have_content 'Recipe 1'
    end

    it 'should display the list of all recipe created by user' do
      @recipes = Recipe.all
      @recipes.each do |recipe|
        expect(page).to have_content(recipe.name)
      end
    end

    it 'should not display a name not in the recipe list' do
      expect(page).to_not have_content 'rice'
    end

    it 'should delete the current recipe' do
      @recipes = Recipe.all
      @recipes.each do |recipe|
        click_on "remove #{recipe.name}"
        expect(page).to_not have_content(recipe.name)
      end
    end

    it 'Add new recipe' do
      click_on 'add recipe'
      expect(page).to have_content('Add new recipe')
    end
  end
end
