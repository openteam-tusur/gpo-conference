class AddFieldsToDiscourses < ActiveRecord::Migration
  def change
    add_column :discourses, :title, :text
    add_column :discourses, :authors, :string
  end
end
