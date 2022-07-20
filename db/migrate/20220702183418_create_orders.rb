# frozen_string_literal: true

# create orders class
class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status, null: false, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
