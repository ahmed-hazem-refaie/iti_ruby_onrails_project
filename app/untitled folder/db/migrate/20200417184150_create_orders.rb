class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :order_for
      t.string :from
      t.string :mimg

      t.timestamps
    end
  end
end
