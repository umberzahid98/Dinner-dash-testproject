# frozen_string_literal: true

# add full name to user
class AddFullNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :string
    # Ex:- :null => false
  end
end
