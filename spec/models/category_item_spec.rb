require 'rails_helper'

RSpec.describe CategoryItem, type: :model do
  describe "association" do
    context 'Within category association' do
      it {  should belong_to(:category) }
      it {  should belong_to(:item) }
    end
  end
end
