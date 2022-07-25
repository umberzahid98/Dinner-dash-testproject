# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :inline_item do
    quantity { rand(1..10) }
    price { Faker::Number.decimal }
    item { FactoryBot.create(:item) }
    trait :user_available do
      user_id { FactoryBot.create(:user).id }
    end

    factory :user_inline_item, traits: [:user_available]

  end
end
