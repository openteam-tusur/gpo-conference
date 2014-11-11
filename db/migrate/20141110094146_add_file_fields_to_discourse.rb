class AddFileFieldsToDiscourse < ActiveRecord::Migration
  def change
    add_column :discourses, :file_file_name, :string
    add_column :discourses, :file_content_type, :string
    add_column :discourses, :file_file_size, :integer
    add_column :discourses, :file_updated_at, :datetime
    add_column :discourses, :file_url, :text
    migrate_discourse

    remove_column :vfs_path, :discourses
  end

  def migrate_discourse
    objects.each do |object|
      path = object.vfs_path.gsub(/http/, 'https')
      object.file_url = path
      object.file_file_name = URI.decode File.basename(path)
      object.save!
    end
  end

  def objects
    @objects ||= Discourse.where("vfs_path IS NOT NULL").where(:file_url => nil)
  end
end
