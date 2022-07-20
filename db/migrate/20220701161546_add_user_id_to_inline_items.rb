# frozen_string_literal: true

# add user to inline items
class AddUserIdToInlineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :inline_items, :user_id, :integer, optional: true
  end
end
