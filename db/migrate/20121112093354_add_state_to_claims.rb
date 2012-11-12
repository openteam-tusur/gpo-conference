class AddStateToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :state, :string
  end
end
