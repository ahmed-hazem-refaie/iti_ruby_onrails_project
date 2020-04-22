class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.text :body
      t.belongs_to  :user
      t.belongs_to :order
      t.string :type

      t.timestamps
    end
  end
end
