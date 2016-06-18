class CreateOrdersItems < ActiveRecord::Migration[5.0]
  def change
    create_table :orders_items do |t|
      t.belongs_to :book, foreign_key: true
      t.decimal :count
      t.decimal :cost
      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
