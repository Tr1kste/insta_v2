# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user factory: :user
    post factory: :post
    content { FFaker::Lorem.phrase }
  end
end
