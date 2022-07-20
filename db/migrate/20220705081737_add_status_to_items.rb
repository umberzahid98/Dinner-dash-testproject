# frozen_string_literal: true

# add status to items
class AddStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :status, :integer, default: 0, presence: true, null: false
  end
end
