# frozen_string_literal: true

# add status to inline items
class AddStatusToInlineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :inline_items, :status, :string, default: 'non-checkedout'
  end
end
