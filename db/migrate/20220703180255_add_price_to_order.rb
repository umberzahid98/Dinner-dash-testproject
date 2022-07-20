# frozen_string_literal: true

# add price to orcer
class AddPriceToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :price, :float, presence: true
  end
end
