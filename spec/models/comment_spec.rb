# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment, user_id: user.id, post_id: post.id) }

  let!(:user) { create :user }
  let!(:post) { create :post }

  describe 'attributes' do
    it { should respond_to(:user_id) }
    it { should respond_to(:post_id) }
    it { should respond_to(:content) }
  end

  describe 'relashionships' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'validates' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_least(5).is_at_most(300) }
    it { expect(subject).to be_valid }
    it 'user invalid' do
      subject.user_id = nil
      is_expected.to be_invalid
    end
    it 'post invalid' do
      subject.post_id = nil
      is_expected.to be_invalid
    end
    it 'comment content invalid' do
      subject.content = nil
      is_expected.to be_invalid
    end
  end
end
