class ChangeVfsPathType < ActiveRecord::Migration
  def change
    change_column :discourses, :vfs_path, :text
  end
end
