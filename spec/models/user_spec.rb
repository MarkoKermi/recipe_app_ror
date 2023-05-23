require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'tobby', email: 'tobby@example.com', password: 'samuel') }

  describe 'create user' do
    it 'should create user' do
      expect(user).to be_valid
    end

    it 'should not valid, name is nil' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'should not valid, email is nil' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'should not valid, password is nil' do
      user.password = ''
      expect(user).to_not be_valid
    end
  end
end
