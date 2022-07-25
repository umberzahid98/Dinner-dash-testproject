# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  context 'with association user' do
    it { should have_many(:orders) }
    it { should have_many(:inline_items) }
  end

  context 'with validating user' do
    it { should validate_length_of :display_name}
    it { should validate_presence_of(:full_name) }
  end

  context 'with user create' do
    it 'default role is user' do
      expect(user.role).to eq("user")
    end
    it 'custom role set to admin ' do
      expect(FactoryBot.create(:admin).role).to eq("admin")
    end
    it 'successfull without display name ' do
      expect(FactoryBot.create(:no_display_name_user).save).to eq(true)
    end

  end
end
