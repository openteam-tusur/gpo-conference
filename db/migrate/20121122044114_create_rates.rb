class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :user
      t.references :discourse
      t.integer :urgency
      t.integer :practicality
      t.integer :novelty
      t.integer :typography
      t.float   :cached_total

      t.timestamps
    end
    add_index :rates, :user_id
    add_index :rates, :discourse_id
  end
end
