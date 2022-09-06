require 'rails_helper'

RSpec.describe User, type: :model do
  context 'basic validation' do

    describe 'username' do
      it 'should always be present' do
        user = User.new(password: 'pass')
        user.should_not be_valid
        expect(user.errors.count).to eql(1)
      end
    end

    describe 'password' do
      it 'should always be present' do
        user = User.new(username: 'test')
        user.should_not be_valid
        expect(user.errors.count).to eql(1)
      end
    end

  end


end
