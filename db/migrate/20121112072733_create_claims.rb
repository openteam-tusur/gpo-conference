class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.references :chair
      t.references :project
      t.references :user
      t.string :role

      t.timestamps
    end
    add_index :claims, :chair_id
    add_index :claims, :project_id
    add_index :claims, :user_id
  end
end
