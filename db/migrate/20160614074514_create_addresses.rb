class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :firstname, null:false
      t.string :lastname, null:false
      t.string :street_address, null:false
      t.string :city, null:false
      t.string :zip, null:false
      t.string :phone, null:false

      t.references :country, foreign_key: true, null:false

      t.timestamps
    end
  end
end
