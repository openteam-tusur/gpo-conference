class AddTitleAndChairIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :title, :string
    add_column :projects, :chair_id, :integer
    add_index :projects, :chair_id
  end
end
