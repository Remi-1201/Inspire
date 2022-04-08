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
  end
    context 'ユーザーがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移' do
        visit blogs_path
        expect(page).to have_content 'Log in'
      end
    end
  describe 'セッション機能' do
    context 'ログイン操作した場合' do
      it 'ログインできる' do
        visit new_user_session_path
        fill_in 'user[name]', with: 'aaa'
        fill_in 'user[email]', with: 'aaa@aaa.com'
        fill_in 'user[password]', with: 'aaaaaa'
        click_on 'Log in'
        expect(page).to have_content 'You have successfully logged in.'
      end
    end
  end

  context 'Profileボタンを押した場合' do
    it '自分のMyPageに飛べる' do
      visit new_user_session_path
      fill_in 'user[name]', with: 'aaa'
      fill_in 'user[email]', with: 'aaa@aaa.com'
      fill_in 'user[password]', with: 'aaaaaa'
      click_on 'Log in'
      click_on 'Profile'
      expect(page).to have_content 'My page'
    end
  end

  context 'ログアウトボタン操作した場合' do
    it 'ログアウトできる' do
      visit new_user_session_path
      fill_in 'user[email]', with: 'bbb@bbb.com'
      fill_in 'user[password]', with: 'bbbbbb'
      click_on 'Log in'
      click_on 'Logout'
      expect(current_path).to eq destroy_user_session_path
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
end