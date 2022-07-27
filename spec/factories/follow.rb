# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    follower_id { :user }
    followee_id { :second_user }
  end
end
