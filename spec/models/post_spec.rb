# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post, user_id: user.id) }

  let(:user) { create :user }

  describe 'relashionships' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one_attached(:image) }
  end

  describe 'attributes' do
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:image) }
    it { is_expected.to respond_to(:user_id) }
  end

  describe 'validates' do
    it { expect(subject).to be_valid }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(5).is_at_most(300) }
    it 'description invalid' do
      subject.description = nil
      is_expected.to_not be_valid
    end
    it 'user_id invalid' do
      subject.user = nil
      expect(subject).to be_invalid
    end
    it 'image nil' do
      expect(build(:post, image: nil)).to_not be_valid
    end
    it 'image invalide' do
      expect(build(:invalid_image)).to be_invalid
    end
  end
end
