require 'rails_helper'

RSpec.describe CategoryItem, type: :model do
  context 'with association category' do
    it {  should belong_to(:category) }
    it {  should belong_to(:item) }
  end
end
