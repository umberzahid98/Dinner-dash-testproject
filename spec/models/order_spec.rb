# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:my_order) { FactoryBot.create(:order) }

  context 'with association order' do
    it { should belong_to(:user) }
  end
  context 'correct attributes' do
    it 'order is saved successfully' do
      expect(my_order.save).to eq(true)
    end
  end

  context 'testing order status' do
    it 'order status by default is ordered' do
      expect(my_order.status).to eq("ordered")
    end
    it 'order status paid as set' do
      expect(FactoryBot.create(:paid_order).status).to eq("paid")
    end
  end
end
