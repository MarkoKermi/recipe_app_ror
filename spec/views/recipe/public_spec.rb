require 'rails_helper'

RSpec.describe 'Recipe', type: :system do
  describe 'public page' do
    before :each do
      visit new_user_session_path
      @user = User.create(name: 'tobby', email: 'tobby2@example.com', password: 'ayomide0803',
                          confirmation_token: 'Mvn7VM3szs3CxwrKA6H', confirmed_at: '2023-05-22 17:16:58.291555',
                          updated_at: '2023-05-22 17:16:58.291555', created_at: '2023-05-22 17:16:58.291555')
      @recipe = Recipe.create(name: 'fish', cooking_time: 10, description: 'we are cooking', preparation_time: 50,
                              user_id: @user.id, public: false)
      @recipetwo = Recipe.create(name: 'doritos', cooking_time: 20, description: 'we are cooking',
                                 preparation_time: 100, user_id: @user.id, public: true)
      @recipethree = Recipe.create(name: 'gumbo', cooking_time: 30, description: 'we are cooking',
                                   preparation_time: 200, user_id: @user.id, public: true)

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on 'Log in'
      click_on 'public recipe'
    end

    it 'page to have' do
      expect(page).to have_content 'Public Recipes'
    end

    it 'page to bot have gumbo' do
      expect(page).to_not have_content 'fish'
    end

    it 'should have the name of each recipe owner and recipe name' do
      @recipes = Recipe.where(public: true)
      @recipes.each do |e|
        expect(page).to have_content(e.user.name.capitalize)
        expect(page).to have_content(e.name.capitalize)
        expect(page).to have_content(e.foods.length)
      end
    end

    it 'should not have the recipe id and recipe description' do
      @recipes = Recipe.where(public: true)
      @recipes.each do |e|
        expect(page).to_not have_content(e.description)
        expect(page).to_not have_content(e.user.id)
        expect(page).to_not have_content(e.id)
      end
    end

    it 'lead to recipe detail page' do
      @recipes = Recipe.where(public: true)
      @recipes.each do |e|
        click_on e.name
        expect(page).to have_content(e.description)
        click_on 'public recipe'
      end
    end

    it 'lead to recipe detail page' do
      @recipes = Recipe.where(public: true)
      @recipes.each do |e|
        expect(page).to have_content("$#{e.foods.sum(:price)}")
      end
    end
  end
end
