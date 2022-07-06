# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Post', :js, type: :feature do
  def sign_in(user)
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: user.password
      click_button 'Войти'
    end
  end

  let(:user) { create(:user) }

  before(:each) do
    visit root_path
    sign_in(user)
  end

  feature 'Post' do
    scenario 'success create & edit & delete post' do
      visit(new_post_path)
      page.attach_file(Rails.root.join('spec/fixtures/pixel.jpeg')) do
        page.find('label', text: 'Выбрать с компьютера').click
      end
      find_field(name: 'post[description]').set('lorem ipsum')
      find('.submit--text').click
      expect(page).to have_content 'Ваш пост опубликован!'
      expect(page).to have_content 'lorem ipsum'
      #   Edit post
      find_by_id('edit_link_id').click
      find_field(name: 'post[description]').set('lorem ipsum edit')
      find('.submit--text').click
      expect(page).to have_content 'Пост обновлен.'
      expect(page).to have_content 'lorem ipsum edit'
      #   Delete post
      find_by_id('delete_link_id').click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_current_path(root_path)
      expect(page).to have_content 'Пост удален.'
    end

    scenario 'failed create post' do
      visit(new_post_path)
      page.attach_file(Rails.root.join('spec/fixtures/pixel.jpeg')) do
        page.find('label', text: 'Выбрать с компьютера').click
      end
      find_field(name: 'post[description]').set('')
      find('.submit--text').click
      expect(page).to have_content 'Ваш новый пост не создан! Пожалуйста, проверьте форму.'
    end

    scenario 'failed edit post' do
      visit(new_post_path)
      page.attach_file(Rails.root.join('spec/fixtures/pixel.jpeg')) do
        page.find('label', text: 'Выбрать с компьютера').click
      end
      find_field(name: 'post[description]').set('lorem ipsum')
      find('.submit--text').click
      expect(page).to have_content 'Ваш пост опубликован!'
      expect(page).to have_content 'lorem ipsum'
      find_by_id('edit_link_id').click
      expect(page).to have_current_path(edit_post_path(1))
      find_field(name: 'post[description]').set('')
      find('.submit--text').click
      expect(page).to have_content 'Ошибка обновления. Пожалуйста, проверьте форму.'
      expect(page).to have_no_content 'Пост обновлен.'
    end
  end

  feature 'Comment' do
    let!(:post) { create(:post) }

    scenario 'success create & delete comment' do
      visit(posts_path)
      within '#new_comment' do
        find_field(name: 'comment[content]').set('lorem ipsum comment')
        find('.submit--text').click
      end
      expect(page).to have_content 'lorem ipsum comment'
      expect(page).to have_current_path(posts_path)
      find('.delete__img').click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_no_content 'lorem ipsum comment'
      expect(page).to have_current_path(posts_path)
    end

    scenario 'failed create comment' do
      visit(posts_path)
      within '#new_comment' do
        find_field(name: 'comment[content]').set('')
        find('.submit--text').click
      end
      expect(page).to have_content 'Комментарий не добавлен! Пожалуйста, проверьте форму.'
    end
  end

  feature 'Like' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }

    scenario 'like & unlike post' do
      visit(posts_path)
      click_link('like', href: like_post_path(post.id))
      expect(page).to have_content "#{user.username} поставили отметки \"Нравится\""
      expect(page).to have_current_path(posts_path)
      click_link('like', href: unlike_post_path(post.id))
      expect(page).to have_no_content "#{user.username} поставили отметки \"Нравится\""
    end
  end
end
