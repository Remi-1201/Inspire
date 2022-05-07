class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :favorites, dependent: :destroy, foreign_key: :user_id
  has_many :blogs, dependent: :destroy, foreign_key: :user_id
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy

  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :rooms, through: :user_rooms
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, omniauth_providers: %i(google)
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.uid = SecureRandom.urlsafe_base64
      user.provider = SecureRandom.urlsafe_base64
    end
  end

  def self.admin_guest
    find_or_create_by!(email: 'admin-guest@example.com', admin: 'true') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.uid = SecureRandom.urlsafe_base64
      user.provider = SecureRandom.urlsafe_base64
    end
  end
  
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(email: auth.info.email,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20],
                                 )
  end
    user.save
    user
  end

  def favorited_by?(blog)
    favorites.where(blog_id: blog.id ).exists? 
  end 
end
