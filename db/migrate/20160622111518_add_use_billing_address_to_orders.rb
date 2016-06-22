class AddUseBillingAddressToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :use_billing_address, :boolean
  end
end
