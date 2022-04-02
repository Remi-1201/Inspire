class Blog < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user, optional: true
  has_many :categorizings, dependent: :destroy
  has_many :categories, through: :categorizings, dependent: :destroy
end