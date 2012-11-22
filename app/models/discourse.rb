# == Schema Information
#
# Table name: discourses
#
#  id          :integer          not null, primary key
#  vfs_path    :string(255)
#  description :text
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :text
#  authors     :string(255)
#

class Discourse < ActiveRecord::Base
  attr_accessible :description, :url, :vfs_path, :authors, :title

  belongs_to :project
  has_one :theme, :through => :project
  has_one :chair, :through => :project
  has_many :comments, :dependent => :destroy
  has_many :rates, :dependent => :destroy

  validates_presence_of :authors, :vfs_path, :title, :description

  serialize :authors

  normalize_attribute :authors do |array|
    array.select { |value| value.present? }
  end

  def rate_for(user)
    rates.rated_by(user).first || rates.rated_by(user).build
  end

end
