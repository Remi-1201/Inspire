require "securerandom"

FactoryBot.define do
  factory :user do
    name { 'aaa' }
    email { 'aaa@aaa.com' }
    password { 'aaaaaa' }
    password_confirmation { 'aaaaaa' }
    admin { 'true' }
    uid { 1234 }
    provider { 'facebook' } 
  end
  factory :user2, class: User do
    name { 'bbb' }
    email { 'bbb@bbb.com' }
    password { 'bbbbbb' }
    password_confirmation { 'bbbbbb' }
    admin { 'false' }
    uid { 2345 }
    provider { 'twitter' } 
  end
    factory :user3, class: User do
    name { 'ccc' }
    email { 'ccc@ccc.com' }
    password { 'cccccc' }
    password_confirmation { 'cccccc' }
    admin { 'false' }
    uid { 3456 }
    provider { 'instagram' } 
  end
end