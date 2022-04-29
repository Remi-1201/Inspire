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
  # seach by detail/word
  scope :search_sort, -> (search_detail){ where('detail LIKE ?', "%#{search_detail}%") }  
  # scope :current_user_sort, -> (current_user_id){ where(user_id: current_user_id) }
 
  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags
    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete
      Tag.find_by(name: old)
    end
    # 新しいタグを保存
    new_tags.each do |new|
      new_blog_tag = Tag.find_or_create_by(name: new, user_id: user.id)
      self.tags << new_blog_tag
    end
  end
end