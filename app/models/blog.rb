class Blog < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user, optional: true
  has_many :categorizings, dependent: :destroy, foreign_key: :blog_id
  has_many :categories, through: :categorizings, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, source: :tag
  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
 
  validates :title, presence: true, length: {maximum: 120}
  validates :detail, presence: true, length: {maximum: 1000}
  scope :kaminari, -> (kaminari_page){ page(kaminari_page).per(10) }

  
  # sort by created_at
  scope :sorted, -> { order(created_at: :desc) }
  # sort by category
  scope :category_sort, -> (search_category){ where(category: search_category) }
  # scope :tag_sort, -> (search_tag){
  #   blogs = Tagging.where(tag_id: search_tag)
  #   ids = blogs.map{ |blog| blog.blog_id }
  #   where(id: ids)
  # }

  # seach by detail/word
  scope :search_sort, -> (search_detail){ where('detail LIKE ?', "%#{search_detail}%") }  
  scope :kaminari, -> (kaminari_page){ page(kaminari_page).per(10) }
  # scope :current_user_sort, -> (current_user_id){ where(user_id: current_user_id) }

end