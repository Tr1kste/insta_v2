require 'rails_helper'

RSpec.describe 'User', :js, type: :feature do
    def sign_in(user)
        within("form") do
            fill_in 'Email', with: user.email
            fill_in 'Пароль', with: user.password
            click_button 'Войти'
        end
    end

    feature 'Sign up' do
        let!(:user) { build(:user) }

        scenario 'success sign up' do
            visit new_user_registration_path
            expect(page).to have_content 'Зарегистрируйтесь, чтобы смотреть фото и видео ваших друзей.'
            within("form") do
                fill_in 'Email', with: user.email
                fill_in 'Ник пользователя', with: user.username
                fill_in 'Пароль', with: user.password
                fill_in 'Подтверждение пароля', with: user.password_confirmation
                click_button 'Зарегистрироваться'
            end
            expect(page).to have_content 'Welcome! You have signed up successfully.'
            expect(page).to have_current_path(root_path)
        end

        scenario 'failed sign up' do
            visit new_user_registration_path
            expect(page).to have_content 'Зарегистрируйтесь, чтобы смотреть фото и видео ваших друзей.'
            within("form") do
                fill_in 'Email', with: user.email
                fill_in 'Ник пользователя', with: user.username
                fill_in 'Пароль', with: user.password
                fill_in 'Подтверждение пароля', with: 'fail'
                click_button 'Зарегистрироваться'
            end
            expect(page).to have_content '1 error'
        end
    end

    feature 'Sign in' do
        let!(:user) { create(:user) }

        scenario 'success sign in' do
            visit root_path
            sign_in(user)
            expect(page).to have_content 'Signed in successfully.'
            expect(page).to have_current_path(root_path)
        end

        scenario 'failed sign in' do
            visit root_path
            within("form") do
                fill_in 'Email', with: user.email
                fill_in 'Пароль', with: nil
                click_button 'Войти'
            end
            expect(page).to have_content 'Invalid Email or password.'
        end
    end

    feature 'Edit user info' do
        let!(:user) { create(:user) }

        scenario 'success edit user info' do
            visit root_path
            sign_in(user)
            visit(user_path(user))
            expect(page).to have_current_path(user_path(user))
            click_link 'Редактировать профиль'
            expect(page).to have_current_path(edit_user_path(user))
            within(".form__main") do
                find_field(name: 'user[name]').set('Кузя')
                find_field(name: 'user[bio]').set('lorem ipsum')
                click_button 'Отправить'
            end
            expect(page).to have_current_path(user_path(user))
            expect(page).to have_content 'Кузя'
            expect(page).to have_content 'lorem ipsum'
        end

        scenario 'failed edit user info' do
            visit root_path
            sign_in(user)
            visit(user_path(user))
            expect(page).to have_current_path(user_path(user))
            click_link 'Редактировать профиль'
            expect(page).to have_current_path(edit_user_path(user))
            within(".form__main") do
                find_field(name: 'user[username]').set('')
                click_button 'Отправить'
            end
            expect(page).to have_content 'Ошибка заполнения. Пожалуйста, проверьте форму.'
        end
    end
end