class CreateOrderdetails < ActiveRecord::Migration[6.0]
  def change
    create_table :orderdetails do |t|
      t.string :item
      t.integer :amount
      t.decimal :price
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
