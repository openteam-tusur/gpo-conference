class MigrateUserId < ActiveRecord::Migration
  def change
    change_column :claims,      :user_id, :string
    change_column :comments,    :user_id, :string
    change_column :permissions, :user_id, :string
    change_column :rates,       :user_id, :string
  end
end
