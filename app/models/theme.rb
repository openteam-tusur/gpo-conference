# == Schema Information
#
# Table name: themes
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  gpo_id        :integer
#  conference_id :integer
#

class Theme < ActiveRecord::Base
  attr_accessible :name, :gpo_id, :conference_id

  belongs_to :conference
  has_many :projects
  has_many :discourses, :through => :projects
  has_many :permissions, :foreign_key => :context_id, :conditions => { :context_type => 'Theme' }
  has_many :experts, :through => :permissions, :source => :user

  validates_presence_of :name, :gpo_id

  scope :ordered_by_name, :order => :name

  alias_attribute :to_s, :name

  def best_three_with_rate
    discourses.with_rates.group_by(&:average_rate).sort.reverse.first(3)
  end
end
