class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order,  foreign_key: true
      t.references :item,   foreign_key: true
      t.integer    :status, default: 0
      t.integer    :quantity
      t.integer    :purchase_price

      t.timestamps
    end
  end
end
