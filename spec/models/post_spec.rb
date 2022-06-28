require 'rails_helper'

RSpec.describe Post, type: :model do
    context 'relashionships' do
        it { should belong_to(:user) }
        it { should have_many(:comments).dependent(:destroy) }
        it { should have_one_attached(:image) }
    end

    context 'validates' do
        let(:user_post) { build(:user, :with_post)}

        it { expect(user_post).to be_valid }
        it { should validate_presence_of(:user_id) }
        it { should validate_presence_of(:description) }
        it { should validate_length_of(:description).is_at_least(5).is_at_most(300) }
    end
end