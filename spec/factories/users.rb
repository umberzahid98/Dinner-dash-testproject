# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    full_name { Faker::Number.decimal }
    display_name {FactoryBot.create(:item)}
    confirmed_at { 1.day.ago }
    password {"password"}

    trait :admin do
      role { "admin" }
    end
    trait :no_display_name do
      display_name { nil }
    end

    factory :admin, traits: [:admin]
    factory :no_display_name_user, traits: [:no_display_name]
  end
end
