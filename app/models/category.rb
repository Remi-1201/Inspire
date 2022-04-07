class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  has_many :blogs, through: :categorizings, dependent: :destroy
  has_many :categorizings, dependent: :destroy, foreign_key: :blog_id
end
