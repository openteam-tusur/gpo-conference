class RemoveChairIdFromClaims < ActiveRecord::Migration
  def up
    remove_column :claims, :chair_id
  end

  def down
    add_column :claims, :chair_id, :integer
    add_index :claims, :chair_id
  end
end
