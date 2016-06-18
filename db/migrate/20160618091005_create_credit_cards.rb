class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.decimal :number
      t.decimal :expiration_month
      t.decimal :expiration_year
      t.decimal :code

      t.timestamps
    end
  end
end
