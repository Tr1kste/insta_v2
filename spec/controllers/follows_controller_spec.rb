require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
    let!(:user) { create(:user) }
    let!(:user2) { create(:second_user) }
    let!(:follow) { create(:follow, follower: user2, followee: user ) }
    let!(:params) { { user_id: user.id } }
       
    before { sign_in user }
    
    context 'before actions' do
        it { should use_before_action(:authenticate_user!) }
        
        it { should use_before_action(:set_user) }
    end

    describe '#followers' do
        subject { get :followers, params: params}

        it 'assigns @followers' do
            subject
            expect(assigns(:followers)).to eq(user.followers)
        end
    end

    describe '#followees' do
        subject { get :followees, params: params}

        it 'assigns @followees' do
            subject
            expect(assigns(:followees)).to eq(user.followees)
        end
    end
end