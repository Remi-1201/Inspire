class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  scope :kaminari, -> (kaminari_page){ page(kaminari_page).per(10) }
  
  validates_uniqueness_of :blog_id, scope: :user_id  

  def render_appropriate_partial
    render 'blogs/index' if is_companies_index_path?
  end
end
