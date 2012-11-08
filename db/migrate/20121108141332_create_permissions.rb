class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user
      t.references :context, :polymorphic => true
      t.string :role
      t.timestamps
    end
    add_index :permissions, [:user_id, :role, :context_id, :context_type], :name => 'by_user_and_role_and_context'

    context = Context.find_or_create_by_title('Root context')

    User.find_or_initialize_by_uid('1').tap do | user |
      user.save(:validate => false)
    user.permissions.create! :context => context, :role => :manager if user.permissions.empty?
    end
  end
end
