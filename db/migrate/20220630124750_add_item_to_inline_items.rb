# frozen_string_literal: true

# add item to inline items
class AddItemToInlineItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :inline_items, :item, foreign_key: true
  end
end
