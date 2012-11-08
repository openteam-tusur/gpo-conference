class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :analysis
      t.text :expected_results
      t.text :features
      t.text :forecast
      t.text :funds_required
      t.text :funds_sources
      t.text :goal
      t.text :novelty
      t.text :purpose
      t.text :release_cost
      t.text :source_data
      t.text :stakeholders
      t.string :title
      t.integer :gpo_id
      t.references :theme

      t.timestamps
    end
  end
end
