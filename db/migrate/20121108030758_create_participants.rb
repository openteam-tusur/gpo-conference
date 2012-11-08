class CreateParticipants < ActiveRecord::Migration
  def change
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
