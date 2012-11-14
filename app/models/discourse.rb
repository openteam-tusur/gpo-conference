class Discourse < ActiveRecord::Base
  attr_accessible :description, :url, :vfs_path, :authors, :title

  belongs_to :project

  validates_presence_of :authors, :vfs_path, :title

  serialize :authors

  normalize_attribute :authors do |array|
    array.select { |value| value.present? }
  end
end
