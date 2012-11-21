class Conference < ActiveRecord::Base
  attr_accessible :ends_on, :starts_on, :year

  has_many :themes
  has_many :projects, :through => :themes
  has_many :project_member_claims
  has_many :claims
  has_many :expert_claims

  def to_param
    year
  end

  def self.current
    find_or_create_by_year Time.zone.today.year.to_s
  end
end
