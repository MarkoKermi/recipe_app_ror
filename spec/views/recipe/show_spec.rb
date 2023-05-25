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
      click_on 'Recipe 1'
    end

    it 'have content, Name of the recipe' do
      expect(page).to have_content 'Recipe 1'
    end

    it 'should display the preparation time of the Recipe 1' do
      expect(page).to have_content 'preparation time: '
    end

    it 'should display the preparation time of the Recipe 1' do
      expect(page).to have_content 'cooking time: '
    end

    it 'should display the preparation time of the Recipe 1' do
      expect(page).to have_content 'text'
    end

    it 'Add Ingredient' do
      click_on 'Add ingredient'
      expect(page).to have_content('Add new Ingredients')
    end

    it 'Generate List' do
      click_on 'generate list'
      expect(page).to have_content('Shopping List')
    end
  end
end
