class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
