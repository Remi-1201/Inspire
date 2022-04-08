require 'rails_helper'

RSpec.describe 'ユーザー登録機能', type: :model do
  it 'emailが空ならバリデーションが通らない' do
    user = User.new(
      email: '',
      password: 'password',
    )
    expect(user).not_to be_valid
  end

  it 'passwordが空ならバリデーションが通らない' do
    user = User.new(
      email: 'aaa@aaa.com',
      password: '',
    )
    expect(user).not_to be_valid
  end
end