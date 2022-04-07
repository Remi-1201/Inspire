30.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = SecureRandom.urlsafe_base64
  uid = SecureRandom.urlsafe_base64
  provider = SecureRandom.urlsafe_base64
  User.create!(name: name,
               email: email,
               password: password,
               uid: uid,
               provider: provider,
               )
end

10.times do |n|
  user_id = rand(5..15) 
  title = Faker::JapaneseMedia::StudioGhibli.character
  detail = Faker::JapaneseMedia::StudioGhibli.quote
Blog.create!( 
  user_id: user_id,
  title: title,
  detail: detail
) 
end

10.times do |n|
  user_id = rand(5..15)
  title = "Matz"
  detail = Faker::Quote.matz
Blog.create!( 
  user_id: user_id,
  title: title,
  detail: detail
) 
end

