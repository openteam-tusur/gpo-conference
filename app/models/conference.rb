# encoding: utf-8
# == Schema Information
#
# Table name: conferences
#
#  id         :integer          not null, primary key
#  year       :string(255)
#  starts_on  :date
#  ends_on    :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hold_on    :date
#


class Conference < ActiveRecord::Base
  attr_accessible :ends_on, :hold_on, :starts_on, :year

  has_many :themes
  has_many :projects, :through => :themes
  has_many :project_member_claims
  has_many :claims
  has_many :expert_claims

  def to_param
    year
  end

  def to_s
    "с #{I18n.l starts_on.to_date, :format => :long} по #{I18n.l ends_on.to_date, :format => :long}"
  end

  def self.current
    current_year = Time.zone.today.year
    find_by_year(current_year.to_s) || find_by_year((current_year-1.year).to_s)
  end
end
