# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InlineItem, type: :model do
  let(:my_inline_item) { FactoryBot.create(:inline_item) }
  let(:user_inline_item) { FactoryBot.create(:user_inline_item) }

  describe "association" do
    context 'with association inline item' do
      it { should belong_to(:user).optional }
      it { should belong_to(:item) }
    end
  end

  describe "validation" do
    context 'when validating inline item' do
      it {should validate_presence_of(:price) }
      it {should validate_presence_of(:quantity) }
      it {should validate_numericality_of(:price).is_greater_than(0)}
      it {should validate_numericality_of(:quantity).is_greater_than(0)}
    end
  end

  describe "test datatype" do
    context 'when testing datatype' do
      it 'integer price should save successfully' do
        my_inline_item.price=15
        expect(my_inline_item.save).to eq(true)
      end
      it 'string price should not save' do
        my_inline_item.price="string price"
        expect(my_inline_item.save).to eq(false)
      end
      it 'string quantity should not save' do
        my_inline_item.quantity="string quantity"
        expect(my_inline_item.save).to eq(false)
      end
      it 'float quantity should not save' do
        my_inline_item.quantity=4.5
        expect(my_inline_item.save).to eq(false)
      end
      it 'integer quantity should save' do
        my_inline_item.quantity=3
        expect(my_inline_item.save).to eq(true)
      end
    end
  end

  describe "signed in user" do
    context "when user is available" do
      it "should save the  user id in inline item" do
      expect(user_inline_item.save).to eq(true)
      end
    end
  end

end
