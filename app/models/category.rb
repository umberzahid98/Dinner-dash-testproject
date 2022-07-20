# frozen_string_literal: true

# category class
class Category < ApplicationRecord
  has_many :category_items, dependent: :destroy
  has_many :items, through: :category_items, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
