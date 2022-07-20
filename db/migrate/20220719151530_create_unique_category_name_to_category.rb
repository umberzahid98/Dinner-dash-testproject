# frozen_string_literal: true

class CreateUniqueCategoryNameToCategory < ActiveRecord::Migration[5.2]
  def change
    add_index :categories, :name, unique: true
  end
end
