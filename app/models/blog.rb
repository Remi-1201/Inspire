class Blog < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user, optional: true
  has_many :categorizings, dependent: :destroy
  has_many :categories, through: :categorizings, dependent: :destroy

  validates :title, presence: true, length: {maximum: 120}
  validates :detail, presence: true, length: {maximum: 1000}
end