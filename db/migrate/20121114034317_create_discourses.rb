class CreateDiscourses < ActiveRecord::Migration
  def change
    create_table :discourses do |t|
      t.string :vfs_path
      t.string :url
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :discourses, :project_id
  end
end
