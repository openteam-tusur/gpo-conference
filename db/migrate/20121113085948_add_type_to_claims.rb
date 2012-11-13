class AddTypeToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :type, :string
  end
end
