require 'rails_helper'

RSpec.describe 'User', type: :feature do

    let(:user) {build :user}
    
    scenario 'Sign up and sign in' do
        visit new_user_registration_path
        expect(page).to have_content 'Зарегистрируйтесь, чтобы смотреть фото и видео ваших друзей.'
        within("form") do
            fill_in 'Email', with: user.email
            fill_in 'Ник пользователя', with: user.username
            fill_in 'Пароль', with: user.password
            fill_in 'Подтверждение пароля', with: user.password
            click_button 'Зарегистрироваться'
        end
        expect(page).to have_content 'Welcome! You have signed up successfully.'
        find(".logout").click
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
        fill_in 'Email', with: user.email
        fill_in 'Пароль', with: user.password
        click_button 'Войти'
        expect(page).to have_content 'Signed in successfully.'
    end
end