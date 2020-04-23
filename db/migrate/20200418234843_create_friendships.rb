class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: true, foreign_key: true
      t.references :friend, null: true, foreign_key: true
      t.references :group, null: true, foreign_key: true

      t.timestamps
    end
  end
end
