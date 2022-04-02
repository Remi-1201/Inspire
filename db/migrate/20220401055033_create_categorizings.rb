class CreateCategorizings < ActiveRecord::Migration[6.0]
  def change
    create_table :categorizings do |t|
      t.references :blog, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
