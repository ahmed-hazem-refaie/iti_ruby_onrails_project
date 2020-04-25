class GroupIdAcceptNull < ActiveRecord::Migration[6.0]
  def change
    change_column :friendships, :group_id, :integer, :default => 0, :null => true
  end
end
