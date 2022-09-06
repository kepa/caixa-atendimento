require 'rails_helper'

RSpec.describe User, type: :model do
  context 'basic validation' do

    describe 'username' do
      it 'should always be present' do
        user = User.new(password: 'pass')
        expect(user.valid?).to eql(false)
        expect(user.errors.count).to eql(1)
      end
    end

    describe 'password' do
      it 'should always be present' do
        user = User.new(username: 'test')
        expect(user.valid?).to eql(false)
        expect(user.errors.count).to eql(1)
      end
    end

  end


end
