# frozen_string_literal: true

# add role to user
class AddRoleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer, default: 0
  end
end
