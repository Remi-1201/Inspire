class Tag < ApplicationRecord
  belongs_to :user, optional: true
  has_many :taggings, dependent: :destroy, foreign_key: 'tag_id'
  has_many :blogs, through: :taggings
  validates :name, presence: true  
end

