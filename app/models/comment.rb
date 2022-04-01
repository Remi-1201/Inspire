class Comment < ApplicationRecord
  belongs_to :blog, optional: true
  belongs_to :user
  validates :content, presence: true
end
