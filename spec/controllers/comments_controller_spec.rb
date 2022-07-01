require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
       
    before { sign_in user }
    
    context 'before actions' do
        it { should use_before_action(:authenticate_user!) }
        
        it { should use_before_action(:set_post) }
    end

    describe '#create' do
        let(:params) { { post_id: post.id, comment: { content: 'comment.content' } } }
        
        context 'success js' do
            subject { process :create, method: :post, params: params, xhr: true }

            it 'create comment' do
                expect { subject }.to change { post.comments.count }.by(1)
            end

            it { expect(subject.content_type).to include('text/javascript') }

            it { expect(subject).not_to have_http_status(:redirect) }
        end

        context 'success html' do
            subject { process :create, method: :post, params: params, xhr: false }

            it 'create comment' do
                expect { subject }.to change { post.comments.count }.by(1)
            end

            it { expect(subject.content_type).to include('text/html') }

            it { should redirect_to(root_path) }
        end

        context 'invalid params comment' do
            subject { process :create, method: :post, params: params }

            let(:params) { { post_id: post.id, comment: { content: nil } } }

            it 'comment not create' do
                expect { subject }.not_to change(post.comments, :count )
            end

            it 'flash message alert create' do
                subject
                expect(flash[:alert]).to be_present
            end

            it { should redirect_to(root_path) }
        end
    end

    describe '#destroy' do
        let!(:params) { { id: comment.id, post_id: post.id } }
        let!(:comment) { create :comment }
        
        before { post.comments << comment }
        
        context 'format js' do
            subject { process :destroy, method: :delete, params: params, xhr: true }
            
            it 'deletes a comment' do
                expect{ subject }.to change { post.comments.count }.by(-1) 
            end
    
            it { expect(subject.content_type).to include('text/javascript') }
    
            it { expect(subject).not_to have_http_status(:redirect) }
        end

        context 'format html' do
            subject { process :destroy, method: :delete, params: params, xhr: false }

            it 'deletes a comment' do
                expect{ subject }.to change { post.comments.count }.by(-1) 
            end

            it { expect(subject.content_type).to include('text/html') }

            it { should redirect_to(root_path) }           
        end
    end
end