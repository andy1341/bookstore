class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :short_description
      t.text :description
      t.belongs_to :author, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.decimal :price
      t.string :image

      t.timestamps
    end
  end
end
