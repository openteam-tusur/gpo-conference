class CreateChairs < ActiveRecord::Migration
  def change
    create_table :chairs do |t|
      t.string :abbr
      t.string :chief
      t.string :faculty
      t.string :title

      t.timestamps
    end
  end
end
