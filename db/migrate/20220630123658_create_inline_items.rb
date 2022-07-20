# frozen_string_literal: true

# create inline items
class CreateInlineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :inline_items do |t|
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
