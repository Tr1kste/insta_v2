# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  subject { build(:follow) }

  describe 'relashionships' do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followee).class_name('User') }
  end

  describe 'validates' do
    it { should validate_uniqueness_of(:follower_id).scoped_to(:followee_id) }
    it { should validate_uniqueness_of(:followee_id).scoped_to(:follower_id) }
    it 'follower invalid' do
      subject.follower_id = nil
      is_expected.to be_invalid
    end
    it 'followee invalid' do
      subject.followee_id = nil
      is_expected.to be_invalid
    end
    it 'follow only once' do
      subject
      is_expected.to be_invalid
    end
  end
end
