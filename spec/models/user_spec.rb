# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'basic validation' do
    describe 'username' do
      it 'alwayses be present' do
        user = described_class.new(password: 'pass')
        user.should_not be_valid
        expect(user.errors.count).to be(1)
      end
    end

    describe 'password' do
      it 'alwayses be present' do
        user = described_class.new(username: 'test')
        user.should_not be_valid
        expect(user.errors.count).to be(1)
      end
    end
  end
end
