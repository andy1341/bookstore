class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.integer :number, limit:8
      t.integer :expiration_month, limit:8
      t.integer :expiration_year, limit:8
      t.integer :code, limit:8

      t.timestamps
    end
  end
end
