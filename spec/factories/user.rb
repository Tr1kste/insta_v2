FactoryBot.define do
    factory :user do
        username { FFaker::Name.name }
        email  { FFaker::Internet.unique.email }
        avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.jpeg'), 'image/jpeg') }
        password { "password" }
        password_confirmation { "password" }
    end

    factory :second_user, class: :user do
        username { FFaker::Name.name }
        email { FFaker::Internet.unique.email }
        avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.jpeg'), 'image/jpeg') }
        password { 'password2' }
        password_confirmation { 'password2' }
    end
end