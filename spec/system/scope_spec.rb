require 'rails_helper'

RSpec.describe 'ページネーションのスコープが機能する', type: :system do  
  let!(:user) { FactoryBot.create(:user) }
  let!(:blog) { FactoryBot.create(:blog, user: user) }
  let!(:second_blog) { FactoryBot.create(:second_blog, user: user) }

  def login
    visit new_user_session_path
    fill_in 'user[email]', with: 'aaa@aaa.com'
    fill_in 'user[password]', with: 'aaaaaa'
    click_on 'Log in'
  end

  describe '投稿の一覧画面を開いたとき' do
    it 'ページネーションが存在し、各ページに10投稿が存在する' do
      login
      28.times do |n|
        FactoryBot.create(:blog, user: user)
      end
      visit blogs_path
        expect(page).to have_selector '.pagination'
        expect(page).to have_selector '.page', count: 3
        expect(Blog.page(1).count).to eq(10)
        expect(Blog.page(2).count).to eq(10)
        expect(Blog.page(3).count).to eq(10)
      end
    end
  end