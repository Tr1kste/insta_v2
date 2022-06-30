require 'rails_helper'

RSpec.describe HomeController, type: :controller do
    let(:user) { create :user }
    let(:params) { { post: attributes_for(:post) } }

    before { sign_in user }

    context 'before actions' do
        it { should use_before_action(:authenticate_user!) }
    end

    describe '#index' do
        subject { process :index, method: :post, params: params }

        let!(:post) { create :post, user: user }

        it 'assigns @posts' do
            subject
            expect(assigns(:posts)).to eq([post])
        end

        it 'assigns @users' do
            subject
            expect(assigns(:users)).to eq([user])
        end

        it { should render_template('index') }

        context 'when user is not sign in' do
            before { sign_out user }
            
            it { should redirect_to(new_user_session_path) }
        end
    end
end