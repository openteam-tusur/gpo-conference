class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.references :project
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :mid_name
      t.integer :gpo_id

      t.timestamps
    end
    add_index :managers, :project_id
  end
end
