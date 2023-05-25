require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'tobby', email: 'tobby@example.com', password: 'samuel') }
  let(:recipe) do
    Recipe.new(name: 'Recipe 1', preparation_time: 1, cooking_time: 2, description: 'text', public: true,
               user_id: user.id)
  end
  describe 'create recipe' do
    it 'should create recipe' do
      expect(recipe).to be_valid
    end
  end

  describe 'validations' do
    it 'should be invalid, name must be present' do
      recipe.name = nil
      expect(recipe).to_not be_valid
    end

    it 'should be invalid, preparation time must be a number' do
      recipe.preparation_time = nil
      expect(recipe).to_not be_valid
    end

    it 'should be invalid, cooking time must be present' do
      recipe.cooking_time = nil
      expect(recipe).to_not be_valid
    end

    it 'should be invalid, description must be a text' do
      recipe.description = nil
      expect(recipe).to_not be_valid
    end

    it 'should be valid if public is true or false' do
      recipe.public = true
      expect(recipe).to be_valid

      recipe.public = false
      expect(recipe).to be_valid
    end
  end
end
