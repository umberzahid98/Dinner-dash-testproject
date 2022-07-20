# frozen_string_literal: true

# inlineitemclass
class InlineItem < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item
  validates :price, presence: true, numericality: { only_float: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
