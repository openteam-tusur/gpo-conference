class AddCipherToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :cipher, :string
  end
end
