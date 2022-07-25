# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :order do
    price { Faker::Number.decimal }
    user {FactoryBot.create(:user)}
    inline_item_ids do
      [
        FactoryBot.create(:user_inline_item, user_id: user.id).id,
        FactoryBot.create(:user_inline_item, user_id: user.id).id,
        FactoryBot.create(:user_inline_item, user_id: user.id).id
      ]
    end

    trait :paid do
      status { "paid" }
    end
    
    factory :paid_order, traits: [:paid]
  end
end
