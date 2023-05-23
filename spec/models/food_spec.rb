require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'tobby', email: 'tobby@example.com', password: 'samuel') }
  let(:food) { Food.new(name: 'beans', quantity: 10, measurement_unit: 'grams', price: 50, user_id: user.id) }
  describe 'create food' do
    it 'should create food' do
      expect(food).to be_valid
    end
  end

  describe 'validations' do
    it 'should be invalid, name must be present' do
      food.name = nil
      expect(food).to_not be_valid
    end

    it 'should be invalid, quantity must be a number' do
      food.quantity = 'food'
      expect(food).to_not be_valid
    end

    it 'should be invalid, measurement_unit must be present' do
      food.measurement_unit = nil
      expect(food).to_not be_valid
    end

    it 'should be invalid, price must be a number' do
      food.price = 'twenty'
      expect(food).to_not be_valid
    end
  end
end
