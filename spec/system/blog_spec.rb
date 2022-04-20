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
          find('#seach_button').hover
          fill_in 'search_detail', with: 'detail1'
          click_on 'Search'
          expect(page).to have_content 'detail1'
          expect(page).not_to have_content 'detail2'
        end
      end

      context 'お気に入り操作をした場合' do
        it "投稿がお気に入り一覧ページに表示される" do
          login
          visit blogs_path
          click_on 'Like', match: :first
          visit favorites_path
          expect(page).to have_content 'detail2'
        end
      end
      context 'お気に入り解除をした場合' do
        it "投稿がお気に入り一覧ページから消える" do
          login
          visit blogs_path
          click_on 'Like', match: :first
          sleep 1
          click_on 'Dislike', match: :first
          visit favorites_path
          expect(page).not_to have_content 'detail2'
        end
      end
  
    describe 'マイページ画面' do
        context 'ユーザーが投稿した場合' do
            it '投稿がマイページに表示される' do
              login
              visit blogs_path         
              click_on 'Make new Post'
              fill_in 'blog[title]', with: 'Harry Potter'
              fill_in 'blog[detail]', with: 'Hogwards'
              click_on 'Submit'
              visit mypage_path
              expect(page).to have_content 'Hogwards'
            end
          end
        end      
    end
end