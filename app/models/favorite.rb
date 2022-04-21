class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  def render_appropriate_partial
    render 'blogs/index' if is_companies_index_path?
  end
end
