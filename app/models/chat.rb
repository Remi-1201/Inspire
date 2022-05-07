class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :message, presence: true
  scope :kaminari, -> (kaminari_page){ page(kaminari_page).per(10) }
end
