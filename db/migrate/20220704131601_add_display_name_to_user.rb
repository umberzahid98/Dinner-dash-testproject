# frozen_string_literal: true

# add display name to user
class AddDisplayNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :display_name, :string
  end
end
