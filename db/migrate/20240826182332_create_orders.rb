class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :customer_email
      t.integer :status, default: 0, null: false
      t.decimal :total_price, precision: 10, scale: 2
      t.datetime :order_date
      t.boolean :payment_status, default: false

      t.timestamps
    end
  end
end
