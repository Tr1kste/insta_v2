require 'rails_helper'

RSpec.describe User, type: :model do
    context 'relashionships' do
        it { should have_many(:comments).dependent(:destroy) }
        it { should have_many(:posts).dependent(:destroy) }
        it { should have_many(:followed_users).with_foreign_key(:follower_id).class_name('Follow') }
        it { should have_many(:followees).through(:followed_users) }
        it { should have_many(:following_users).with_foreign_key(:followee_id).class_name('Follow') }
        it { should have_many(:followers).through(:following_users) }
        it { should have_one_attached(:avatar) }
    end
    
    context 'validates' do
        subject { build(:user) }

        it { should validate_presence_of(:username) }
        it { should validate_length_of(:username).is_at_least(4)}
        it { should validate_presence_of(:email) }
        it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
        it { expect(subject).to be_valid }
    end
end