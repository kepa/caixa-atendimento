require 'rails_helper'

RSpec.describe User, type: :model do
  context 'basic validation' do

    describe 'username' do
      it 'should always be present' do
        user = User.new
        expect(user.valid?).to eql(false)
      end
    end

  end

  context 'User creation' do

  end

end
