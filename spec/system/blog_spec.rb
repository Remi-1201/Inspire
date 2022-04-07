require 'rails_helper'
RSpec.describe 'ブログ管理機能', type: :system do  
  let!(:user) { FactoryBot.create(:user) }
  let!(:blog) { FactoryBot.create(:blog, user: user) }
  let!(:second_blog) { FactoryBot.create(:second_blog, user: user) }

  def login
    visit new_user_session_path
    fill_in 'user[email]', with: 'aaa@aaa.com'
    fill_in 'user[password]', with: 'aaaaaa'
    click_on 'Log in'
  end

  describe 'ブログの一覧画面' do
    context 'ブログを新規作成した場合' do
        it '作成したブログが表示される' do
          login
          visit blogs_path          
          expect(page).to have_content 'detail1'
        end
      end
    context '検索をした場合' do
        it "ブログの内容をあいまい検索できる" do
          login
          visit blogs_path
          fill_in 'search_detail', with: 'detail1'
          click_on 'Search'
          expect(page).to have_content 'detail1'
          expect(page).not_to have_content 'detail2'
        end
      end
    end
end