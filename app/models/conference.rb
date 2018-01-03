class Conference < ActiveRecord::Base
  has_many :themes, -> { order('themes.name').uniq }
  has_many :projects, :through => :themes
  has_many :project_member_claims
  has_many :claims
  has_many :expert_claims
  has_many :discourses, -> { select('themes.name, discourses.*').uniq }, :through => :projects

  def to_param
    year
  end

  def to_s
    "с #{I18n.l starts_on.to_date, :format => :long} по #{I18n.l ends_on.to_date, :format => :long}"
  end

  def self.current
    #current_year = Time.zone.today.year
    #find_by_year(current_year.to_s).presence || find_by_year((current_year-1).to_s)

    Conference.order(:year).last
  end

  def best_three_with_rate
    discourses.with_rates.group_by(&:average_rate).sort.reverse.first(3)
  end
end
