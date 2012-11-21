class Discourse < ActiveRecord::Base
  attr_accessible :description, :url, :vfs_path, :authors, :title

  belongs_to :project
  has_one :theme, :through => :project
  has_one :chair, :through => :project
  has_many :comments, :dependent => :destroy

  validates_presence_of :authors, :vfs_path, :title, :description

  serialize :authors

  normalize_attribute :authors do |array|
    array.select { |value| value.present? }
  end
end
