class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :total
      t.date :completed_date
      t.integer :status
      t.belongs_to :user
      t.belongs_to :billing_address
      t.belongs_to :shipping_address
      t.belongs_to :delivery
      t.belongs_to :credit_card

      t.timestamps
    end
  end
end
