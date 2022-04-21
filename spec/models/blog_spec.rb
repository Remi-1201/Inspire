require 'rails_helper'

RSpec.describe 'ブログ管理機能', type: :model do
 
  context 'ブログのタイトルが空の場合' do
    it 'バリデーションにひっかる' do
      blog = Blog.new(title: '', detail: '失敗テスト')
      expect(blog).not_to be_valid
    end
  end
  context 'ブログの詳細が空の場合' do
    it 'バリデーションにひっかかる' do
      blog = Blog.new(title: '失敗テスト', detail: '')
      expect(blog).not_to be_valid
    end
  end
  context 'ブログのタイトルと詳細に内容が記載されている場合' do
    it 'バリデーションが通る' do
      blog = Blog.new(title: '成功テスト', detail: '成功テスト')
      expect(blog).to be_valid
    end
  end    
end
