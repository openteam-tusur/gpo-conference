# encoding: utf-8

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

  def to_s
    "Конференция #{year}, с #{I18n.l starts_on.to_date, :format => :long} по #{I18n.l ends_on.to_date, :format => :long}"
  end

  def self.current
    current_year = Time.zone.today.year
    find_by_year(current_year.to_s) || find_by_year((current_year-1.year).to_s)
  end
end
