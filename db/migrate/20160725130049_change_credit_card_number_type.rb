class ChangeCreditCardNumberType < ActiveRecord::Migration[5.0]
  reversible do |dir|
    change_table :credit_cards do |t|
      dir.up   do
        t.change :number, :string
        t.change :expiration_month, :string
        t.change :expiration_year, :string
        t.change :code, :string
      end
      dir.down do
        t.change :number, :integer, limit: 8
        t.change :expiration_month, :integer, limit: 8
        t.change :expiration_year, :integer, limit: 8
        t.change :code, :integer, limit: 8
      end
    end
  end
end