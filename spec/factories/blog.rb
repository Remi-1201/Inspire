FactoryBot.define do
   factory :blog do
    title { 'title1' }
    detail { 'detail1' }
  end
  factory :second_blog, class: Blog do
    title { 'title2' }
    detail { 'detail2' }
  end
end