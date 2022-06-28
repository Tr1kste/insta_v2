require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    let(:user) { create :user }
    let(:params) { { post: attributes_for(:post) } }

    before { sign_in user }

    describe '#index' do
        subject { process :index, method: :post, params: params }

        let!(:post) { create :post, user: user }

        it 'assigns @posts' do
            subject
            expect(assigns(:posts)).to eq([post])
        end

        it { should render_template('index') }

        context 'when user is not sign in' do
            before { sign_out user }
            it { should redirect_to(new_user_session_path) }
        end
    end

    describe '#show' do
        
    end

    describe '#new' do
        subject { process :new }

        it 'assigns @post' do
            subject
            expect(assigns(:post)).to be_a_new Post
        end

        it { should render_template('new') }
    end

    describe '#create' do
        context 'success' do
            subject { process :create, method: :post, params: params }

            let(:params) { { post: attributes_for(:post, user: create(:user)) } }

            it 'create a post' do
                expect { subject }.to change(Post, :count).by(1)
                expect(flash[:success]).to be_present
            end

            it { should redirect_to(root_path) }

            it 'assigns post to current user' do
                subject
                expect(assigns(:post).user).to eq user
            end
        end

        context 'invalid params' do
            subject { process :create, method: :post, params: params }

            let(:params) { { post: { user_id: nil, post: { description: nil } } } }

            it { should render_template('new') }

            it 'post not create' do
                expect { subject }.not_to change(user.posts, :count )
                expect(flash[:alert]).to be_present
            end
        end
    end

    describe '#destroy' do
        subject { process :destroy, method: :delete, params: params }
        let!(:post) { create :post, user: user }
        let(:params) { { id: post.id } }
        
        it 'deletes the post' do
            expect { subject }.to change(user.posts, :count).by(-1)
            expect(flash[:success]).to be_present
            should redirect_to(root_path)
        end

        context 'user tries to remove someones post' do
            let!(:post) { create :post }
    
            it 'exception' do
                expect { subject }.to raise_exception(ActiveRecord::RecordNotFound).and(
                    change(user.posts, :count).by(0)
                )
            end
        end       
    end
end