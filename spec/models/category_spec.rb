# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:my_category) { FactoryBot.create(:category) }
  describe "association" do
    context 'with association category' do
      it { is_expected.to have_many(:category_items) }
      it { is_expected.to have_many(:items).through(:category_items) }
    end
  end
  describe "validation" do
    context 'when validating name' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
