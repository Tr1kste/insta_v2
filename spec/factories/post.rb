FactoryBot.define do
    factory :post do
        user factory: :user
        description { FFaker::Lorem.phrase }
        image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.jpeg'), 'image/jpeg') }
    end
end