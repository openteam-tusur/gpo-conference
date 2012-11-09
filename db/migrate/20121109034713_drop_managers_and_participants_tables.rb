class DropManagersAndParticipantsTables < ActiveRecord::Migration
  def up
    drop_table :managers
    drop_table :participants
  end

  def down
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

    create_table :participants do |t|
      t.references :project
      t.integer :course
      t.string :edu_group
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :mid_name
      t.integer :gpo_id

      t.timestamps
    end
    add_index :participants, :project_id
  end
end
