class MigrateToSsoAuth < ActiveRecord::Migration
  def up
    drop_table :contexts

    drop_table :subcontexts

    remove_column :users, :nickname, :location, :description, :image, :phone, :urls
  end

  def down
    change_table :users do |t|
      t.text     "nickname"
      t.text     "location"
      t.text     "description"
      t.text     "image"
      t.text     "phone"
      t.text     "urls"
    end

    create_table "contexts", :force => true do |t|
      t.string   "title"
      t.string   "ancestry"
      t.string   "weight"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "contexts", ["ancestry"], :name => "index_contexts_on_ancestry"
    add_index "contexts", ["weight"], :name => "index_contexts_on_weight"

    create_table "subcontexts", :force => true do |t|
      t.string   "title"
      t.integer  "context_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end
