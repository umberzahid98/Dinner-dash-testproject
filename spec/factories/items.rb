# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :item do
    title { Faker::Lorem.unique.word}
    description { Faker::Lorem.sentences }
    price { Faker::Number.decimal }
    categories do
      [
        FactoryBot.create(:category),
        FactoryBot.create(:category),
        FactoryBot.create(:category)
      ]
    end

    after(:build) do |item|
      item.image.attach(io: File.open('spec/profile.png'), filename: 'profile.png', content_type: 'image/png')
    end

    trait :permit do
      status { 0 }
    end

    factory :permited_items, traits: [:permit]
  end
end
