# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:my_item) { FactoryBot.create(:item) }

  context 'with association item' do
    it { is_expected.to have_many(:category_items) }
    it { is_expected.to have_many(:categories).through(:category_items) }
  end

  context 'when validating item' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:title) }
    # it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    # it 'item image attached' do
    #   expect(my_item.image).to be_attached
    # end
    it {should validate_numericality_of(:price).is_greater_than(0)}
  end

  context 'when testing scope' do
    it 'includes items where status is permit' do
      item = FactoryBot.create(:permited_items)
      expect(Item.permited_items).to include(item)
    end
  end

  context 'when testing datatype' do
    it 'integer price should save successfully' do
      my_item.price=15
      expect(my_item.save).to eq(true)
    end
    it 'string price should not save' do
      my_item.price="string price"
      expect(my_item.save).to eq(false)
    end
  end
end
