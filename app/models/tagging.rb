class Tagging < ApplicationRecord
  belongs_to :blog
  belongs_to :tag
  validates :blog_id, presence: true
  validates :tag_id, presence: true
end
