class RemoveColumnsFromProjects < ActiveRecord::Migration
  def up
      remove_column :projects, :analysis
      remove_column :projects, :expected_results
      remove_column :projects, :features
      remove_column :projects, :forecast
      remove_column :projects, :funds_required
      remove_column :projects, :funds_sources
      remove_column :projects, :goal
      remove_column :projects, :novelty
      remove_column :projects, :purpose
      remove_column :projects, :release_cost
      remove_column :projects, :source_data
      remove_column :projects, :stakeholders
      remove_column :projects, :title
  end

  def down
    add_column :projects, :analysis, :text
    add_column :projects, :expected_results, :text
    add_column :projects, :features, :text
    add_column :projects, :forecast, :text
    add_column :projects, :funds_required, :text
    add_column :projects, :funds_sources, :text
    add_column :projects, :goal, :text
    add_column :projects, :novelty, :text
    add_column :projects, :purpose, :text
    add_column :projects, :release_cost, :text
    add_column :projects, :source_data, :text
    add_column :projects, :stakeholders, :text
    add_column :projects, :title, :string
  end
end
