class AddBlogRefToTaggings < ActiveRecord::Migration[6.0]
  def change
    add_reference :taggings, :blog, null: false, foreign_key: true
  end
end
