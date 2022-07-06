# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user factory: :user
    description { FFaker::Lorem.phrase }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.jpeg'), 'image/jpeg') }

    factory :invalid_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/notimage.txt'), 'text/plain') }
    end
  end
end
