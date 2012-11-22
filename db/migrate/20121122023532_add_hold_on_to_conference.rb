class AddHoldOnToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :hold_on, :date
  end
end
