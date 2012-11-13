class AddThemeToClaims < ActiveRecord::Migration
  def up
    add_column :claims, :theme_id, :integer
    add_index :claims, :theme_id
  end

  def down
    remove_column :claims, :theme_id
  end
end
