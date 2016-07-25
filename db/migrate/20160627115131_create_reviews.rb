class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :text
      t.string :rating
      t.integer :status, default: 0
      t.references :reviewable, polymorphic: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
