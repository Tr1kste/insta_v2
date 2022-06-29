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
        subject { process :show, params: params }

        let(:params) { { user_id: user.id, id: post } }
        let!(:post) { create :post, user: user }
      
        it 'assigns @post' do
          subject
          expect(assigns(:post)).to eq(post)
        end
      
        it { should render_template('show') }
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
        subject { process :create, method: :post, params: params }
        
        context 'success' do
            let(:params) { { post: attributes_for(:post, user: create(:user)) } }

            it 'create a post' do
                expect { subject }.to change(Post, :count).by(1)
            end

            it 'flash message success create' do
                subject
                expect(flash[:success]).to be_present
            end

            it { should redirect_to(root_path) }

            it 'assigns post to current user' do
                subject
                expect(assigns(:post).user).to eq user
            end
        end

        context 'invalid params' do
            let(:params) { { post: { user_id: nil, post: { description: nil } } } }

            it { should render_template('new') }

            it 'post not create' do
                expect { subject }.not_to change(user.posts, :count )
            end

            it 'flash message alert create' do
                subject
                expect(flash[:alert]).to be_present
            end
        end
    end

    describe '#edit' do
        subject { process :edit, method: :get, params: params }

        let(:params) { { id: post, user_id: user } }   
        let!(:post) { create :post, user: user }
      
        it { should render_template('edit') }
      
        it 'assigns server policy' do
          subject
          expect(assigns :post).to eq post
        end

        context 'user tries to update someones post' do
            let!(:post) { create :post }

            it { should redirect_to(root_path) }
    
            it 'does not update post' do
                expect { subject }.not_to change { post.reload }
            end

            it 'flash message alert edit' do
                subject
                expect(flash[:alert]).to be_present
            end
        end
    end
    
    describe '#update' do
        subject { process :update, method: :put, params: params }

        let!(:post) { create :post, user: user }
        let(:params) { { id: post, user_id: user, post: { description: 'description' } } }

        it { should redirect_to(post_path(post.id)) }

        it 'updates post' do
            expect { subject }.to change { post.reload.description }.to('description')
        end

        it 'flash message success update' do
            subject
            expect(flash[:success]).to be_present
        end

        context 'with bad params' do
            let(:params) { { id: post, user_id: user, post: { description: '' } } }

            it 'does not update post' do
                expect { subject }.not_to change { post.reload.description }
            end

            it 'flash message alert update' do
                subject
                expect(flash[:alert]).to be_present
            end

            it { should render_template('edit') }
        end
    end      

    describe '#destroy' do
        subject { process :destroy, method: :delete, params: params }
        
        let(:params) { { id: post.id } }
        
        context 'success delete' do
            let!(:post) { create :post, user: user }

            it 'delete the post' do
                expect { subject }.to change(user.posts, :count).by(-1) 
            end
    
            it 'flash message success delete' do
                subject
                expect(flash[:success]).to be_present
            end
            
            it { should redirect_to(root_path) }
        end

        context 'user tries to remove someones post' do
            let!(:post) { create :post }

            it { should redirect_to(root_path) }
    
            it 'does not delete post' do
                expect { subject }.not_to change(user.posts, :count )
            end

            it 'flash message alert delete' do
                subject
                expect(flash[:alert]).to be_present
            end
        end       
    end

    describe '#like' do
        subject { process :like, params: params, xhr: false }

        let(:params) { { id: post, user_id: user } }
        let!(:post) { create :post, user: user }
        let(:votes) { post.votes_for.up }

        it 'like post' do
            expect { subject }.to change { votes.size }.by(1)
        end

        it { expect(subject.content_type).to include('text/html') }

        it { should redirect_to(root_path) }

        context 'js format' do
            subject { process :like, params: params, xhr: true }

            it 'like post' do
                expect { subject }.to change { votes.size }.by(1)
            end

            it { expect(subject.content_type).to include('text/javascript') }

            it { expect(subject).not_to have_http_status(:redirect) }
        end
    end

    describe '#unlike' do
        subject { process :unlike, params: params, xhr: false }

        let(:params) { { id: post, user_id: user } }
        let!(:post) { create :post, user: user }
        let!(:vote_up) { post.liked_by user }
        let(:votes) { post.votes_for }

        it 'unlike post' do
            expect { subject }.to change { votes.size }.by(-1)
        end

        it { expect(subject.content_type).to include('text/html') }

        it { should redirect_to(root_path) }

        context 'js format' do
            subject { process :unlike, params: params, xhr: true }

            it 'unlike post' do
                expect { subject }.to change { votes.size }.by(-1)
            end

            it { expect(subject.content_type).to include('text/javascript') }

            it { expect(subject).not_to have_http_status(:redirect) }
        end
    end
end