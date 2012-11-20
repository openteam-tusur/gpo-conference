class AddConferenceIdToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :conference_id, :integer
  end
end
