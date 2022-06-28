require 'rails_helper'

RSpec.describe Comment, type: :model do
    context 'validates' do
        subject { build(:comment)}

        it { should validate_presence_of(:content) }
        it { should validate_length_of(:content).is_at_least(5).is_at_most(300) }
        it { expect(subject).to be_valid }
    end
    
    context 'relashionships' do
        it { should belong_to(:user) }
        it { should belong_to(:post) }
    end
end