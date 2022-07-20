# frozen_string_literal: true

class AddUniqueTitleToItems < ActiveRecord::Migration[5.2]
  def change
    add_index :items, :title, unique: true
  end
end
