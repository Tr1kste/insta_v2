FactoryBot.define do
    factory :user do
        username { FFaker::Name.name }
        email  { FFaker::Internet.unique.email }
        password { "password" }
        password_confirmation { "password" }

        trait :with_post do
            after(:build) do |user|
                build(:post, user_id: user.id)
            end
        end
    end
end