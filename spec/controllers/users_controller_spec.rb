require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let(:user) { create :user }
    let(:params) { { id: user } }

    before { sign_in user }

    context 'before actions' do
        it { should use_before_action(:authenticate_user!) }
    
        it { should use_before_action(:set_user) }
    end

    describe '#index' do
        subject { process :index }

        it { expect{ subject }.to raise_error(ActionController::UrlGenerationError) }
    end

    describe '#show' do
        subject { process :show, method: :get, params: params }
      
        it { should render_template('show') }

        it 'assigns @user' do
            subject
            expect(assigns :user).to eq user
        end

        context 'non authorize user' do
            before { sign_out user }

            it { should redirect_to(new_user_session_path) }
        end
    end

    describe '#edit' do
        subject { process :edit, method: :get, params: params }
      
        it { should render_template('edit') }
      
        it 'assigns server policy' do
          subject
          expect(assigns :user).to eq user
        end
    end

    describe '#update' do
        subject { process :update, method: :put, params: params }

        context 'success update' do
            let(:params) { { id: user, user: { website: 'myweb.com', name: 'Kulich' } } }

            it 'updates users bio' do
                expect { subject }.to change { user.reload.website }.to('myweb.com')
            end

            it 'updates users name' do
                expect { subject }.to change { user.reload.name }.to('Kulich')
            end

            it 'permit' do
                should permit(:bio, :name).for(:update, params: params).on(:user)
            end

            it 'assigns server policy' do
                subject
                expect(assigns :user).to eq user
            end

            it 'flash message success update' do
                subject
                expect(flash[:success]).to be_present
            end

            it { should redirect_to(user_path(user.id)) }
        end

        context 'invalid params' do
            let(:params) { { id: user, user: { username: nil } } }

            it 'doesnt updates users bio' do
                expect { subject }.not_to change { user.reload.username }
            end

            it { should render_template('edit') }

            it 'flash message alert update' do
                subject
                expect(flash[:alert]).to be_present
            end
        end
    end

    describe '.user_params' do
        let(:params) { { user: attributes_for(:user) } }

        it 'permit user params' do
            params = {
                id: user.id,
                user: {
                    name: 'vasia',
                    website: 'myweb.com',
                    bio: 'bio',
                    phone: '12345',
                    gender: 'male'
                }
            }
            should permit(:username, :name, :website,
                :bio, :email, :phone, :gender, :avatar).
                for(:update, params: params).
                on(:user)
        end
    end
end