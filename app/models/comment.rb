class Comment < ApplicationRecord
  belongs_to :user, optional: true 
  belongs_to :blog, optional: true
  validates :content, presence: true
end
