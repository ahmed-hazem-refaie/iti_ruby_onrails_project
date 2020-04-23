class CreateActivites < ActiveRecord::Migration[6.0]
  def change
    create_table :activites do |t|
      t.text :action
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
