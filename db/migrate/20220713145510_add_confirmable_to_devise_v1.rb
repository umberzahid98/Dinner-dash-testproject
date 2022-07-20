# frozen_string_literal: true

# add confirmable to devise
class AddConfirmableToDeviseV1 < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :users, bulk: true do |t|
        dir.up do
          t.remove_column :confirmed_at
          t.add_column :confirmed_at, :datetime
        end
        dir.down do
          t.remove_index :confirmation_token
          t.remove_columns :confirmation_token, :confirmed_at, :confirmation_sent_at
        end
      end
    end
  end
end
