# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:my_item) { FactoryBot.create(:item) }

  describe "association" do
    context 'In item association' do
      it { is_expected.to have_many(:category_items) }
      it { is_expected.to have_many(:categories).through(:category_items) }
    end
  end

  describe "validation" do
    context 'In validating item' do
      it { is_expected.to validate_presence_of(:status) }
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:description) }
      it {should validate_numericality_of(:price).is_greater_than(0)}
    end
  end

  describe "scope" do
    context 'when testing scope' do
      it 'includes items where status is permit' do
        item = FactoryBot.create(:permited_items)
        expect(Item.permited_items).to include(item)
      end
    end
  end

  describe "datatype" do
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

  describe "with absent category" do
    context "saving item" do
      it " is not expected to save the item" do
        my_item.category_ids=[]
        expect(my_item.save).to eq(false)
      end
    end
  end
  
end
