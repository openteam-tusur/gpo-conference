class AddGpoIdToChairsAndThemes < ActiveRecord::Migration
  def change
    add_column :chairs, :gpo_id, :integer
    add_column :themes, :gpo_id, :integer
  end
end
