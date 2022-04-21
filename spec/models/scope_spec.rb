require 'rails_helper'

RSpec.describe 'ページネーションのスコープが機能する', type: :model do  
  let!(:user) { FactoryBot.create(:user) }
  let!(:blog) { FactoryBot.create(:blog, user: user) }
  let!(:second_blog) { FactoryBot.create(:second_blog, user: user) }

  describe '投稿の一覧画面を開いたとき' do
    it '各ページに10投稿が存在する' do
      28.times do |n|
        FactoryBot.create(:blog, user: user)
      end
        expect(Blog.count).to eq(30)
        expect(Blog.page(1).count).to eq(10)
        expect(Blog.page(2).count).to eq(10)
        expect(Blog.page(3).count).to eq(10)
      end
    end
  end