# frozen_string_literal: true

# item creation migration
class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title, null: false, unique: true
      t.text :description, null: false
      t.float :price

      t.timestamps
    end
  end
end
