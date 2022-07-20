# frozen_string_literal: true

# remove presence
class RemovePresenceTrueFromUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :full_name, :string, null: false
  end

  def down
    change_column :users, :full_name, :string, null: false
  end
end
