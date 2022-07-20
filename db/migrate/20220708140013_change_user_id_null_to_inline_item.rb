# frozen_string_literal: true

# change user id null to inline item
class ChangeUserIdNullToInlineItem < ActiveRecord::Migration[5.2]
  def change
    change_column_null :inline_items, :user_id, true
  end
end
