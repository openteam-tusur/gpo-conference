class AddConferenceIdToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :conference_id, :integer
  end
end
