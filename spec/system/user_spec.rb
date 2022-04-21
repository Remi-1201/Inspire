require 'rails_helper' 
require 'spec_helper'

RSpec.describe 'ユーザー機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user2) }
  let!(:user3) { FactoryBot.create(:user3) }
  
  before do
    visit new_user_session_path
  end

  describe 'ユーザー新規作成機能' do
    context 'ユーザー新規作成した場合' do
      it 'ユーザー新規登録できる' do
        visit new_user_registration_path
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@test.com'
        fill_in 'user[password]', with: 'testtest'
        fill_in 'user[password_confirmation]', with: 'testtest'
        click_on 'Submit'
        expect(page).to have_content 'Welcome! You have signed up successfully.'
      end
    end
    context 'ユーザーがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移' do
        visit blogs_path
        expect(page).to have_content 'Login'
        expect(page).not_to have_content 'All posts'
      end
    end
  end

  describe 'セッション機能' do
    context 'ログイン操作した場合' do
      it 'ログインできる' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'aaa@aaa.com'
        fill_in 'user[password]', with: 'aaaaaa'
        click_on 'Log in'
        expect(page).to have_content 'You have successfully logged in.'
      end
    end  
  context 'Profileボタンを押した場合' do
    it '自分のMyPageに飛べる' do
      visit new_user_session_path
      fill_in 'user[email]', with: 'aaa@aaa.com'
      fill_in 'user[password]', with: 'aaaaaa'
      click_on 'Log in'
      click_on 'Profile'
      expect(page).to have_content 'aaa'
    end
  end
  context  'ログアウトボタン操作した場合'  do
    it 'ログアウトできる' do
      visit new_user_session_path
      fill_in 'user[email]', with: 'bbb@bbb.com'
      fill_in 'user[password]', with: 'bbbbbb'
      click_on 'Log in'
      find('#menu').hover
      click_on 'Logout'
      expect(current_path).to eq destroy_user_session_path
      end
    end
  end

  describe 'ゲストセッション機能' do
    context 'ゲストログイン操作した場合' do
      it 'ゲストログインできる' do
        visit new_user_session_path
        click_on 'Guest login'
        expect(page).to have_content 'You have successfully logged in as a guest user.'
      end
    end
    context 'ゲスト管理者ログイン操作した場合' do
      it 'ゲスト管理者ログインできる' do
        visit new_user_session_path
        click_on 'Admin guest login'
        expect(page).to have_content 'You have successfully logged in as an admin guest.'
      end
    end
  end  

  describe '管理者機能' do
    context '管理者がログインした場合' do
      it 'Adminリンクが表示される' do
        visit new_user_session_path
        click_on 'Admin guest login'
        find('#menu').hover
        expect(page).to have_link 'Admin'
      end
    end
      it '管理者画面に入れる' do
        visit new_user_session_path
        click_on 'Admin guest login'
        find('#menu').hover
        click_on 'Admin'
        expect(page).to have_text 'Dashboard'
      end    
    context '一般ユーザーがログインした場合' do
      it 'Adminリンクが表示されない' do
        visit new_user_session_path
        click_on 'Guest login'
        find('#menu').hover
        expect(page).not_to have_link 'Admin'
      end
    end  
  end  
end