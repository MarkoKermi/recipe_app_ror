require 'rails_helper'

RSpec.describe 'food', type: :system do
  describe 'food' do
    before :each do
      visit new_user_session_path
      @user = User.create(name: 'tobby', email: 'tobby1@example.com', password: 'ayomide0803',
                          confirmation_token: 'Mvn7VM3szs3CxwrKAHoH', confirmed_at: '2023-05-22 17:16:58.291555',
                          updated_at: '2023-05-22 17:16:58.291555', created_at: '2023-05-22 17:16:58.291555')
      @food = Food.create(name: 'beans', quantity: 10, measurement_unit: 'grams', price: 50, user_id: @user.id)
      @foodtwo = Food.create(name: 'rice', quantity: 20, measurement_unit: 'grams', price: 100, user_id: @user.id)
      @foodthree = Food.create(name: 'yam', quantity: 30, measurement_unit: 'grams', price: 200, user_id: @user.id)
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on 'Log in'
    end

    it 'have content, Here is the list of all food in your catalogue' do
      expect(page).to have_content 'Here is the list of all food in your catalogue'
    end

    it 'should display the first food created by the user' do
      expect(page).to have_content 'beans'
    end

    it 'should display the list of all food created by user' do
      @foods = Food.all
      @foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end

    it 'should not display a name not in the food list' do
      expect(page).to_not have_content 'tacos'
    end

    it 'should delete the current food' do
      @foods = Food.all
      @foods.each do |food|
        click_on "delete #{food.name}"
        expect(page).to_not have_content(food.name)
      end
    end

    it 'Add new food' do
      click_on 'Add food'
      expect(page).to have_content('Add new food')
    end
  end
end
