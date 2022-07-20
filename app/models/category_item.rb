# frozen_string_literal: true

# model joining category and items
class CategoryItem < ApplicationRecord
  belongs_to :category, inverse_of: :category_items
  belongs_to :item, inverse_of: :category_items
end
