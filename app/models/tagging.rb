class Tagging < ApplicationRecord
  belongs_to :blog, optional: true
  belongs_to :tag, optional: true
  validates :blog_id, presence: true
  validates :tag_id, presence: true
end
