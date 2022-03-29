class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.text :detail

      t.timestamps
    end
  end
end
