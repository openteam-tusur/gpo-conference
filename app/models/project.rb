require 'open-uri'

class Project < ActiveRecord::Base
  belongs_to :chair
  belongs_to :theme

  has_many :discourses
  has_many :permissions,    :foreign_key => :context_id
  has_one  :conference, :through => :theme

  validates_presence_of :chair, :gpo_id, :theme

  delegate :analysis, :expected_results, :forecast, :funds_required, :funds_sources, :goal,
    :novelty, :purpose, :release_cost, :source_data, :stakeholders, :participants, :managers,
    to: :project_attributes

  delegate :abbr, :to => :chair, :prefix => true

  scope :ordered_by_title, -> { order(:chair_id, :title) }

  scope :for_current_conference, -> { joins(:theme).where(:themes => { :conference_id => Conference.current }) }

  def users
    @users ||= permissions.map(&:user).compact
  end

  def project_members
    @project_members ||= permissions.where(:role => :participant).map(&:user).compact
  end

  def complex_title
    "#{cipher} #{title}"
  end

  def role_for(user)
    return :participant if member?(:participant, user)
    return :manager if member?(:manager, user)
  end

  def rated_by?(user)
    rates.for_user(user).any?
  end

  def to_s
    "#{cipher} #{title}"
  end

  def capitalized_title
    title.mb_chars.downcase.gsub(/"/, '').sub /^./ do |l|
      l.mb_chars.capitalize
    end
  end

  private

  def member?(role, user)
    self.send(role.to_s.pluralize).each do |member|
      return true if member.name == user.fullname
    end

    false
  end

  def response
    @response ||= open("#{Settings['gpo.url']}/api/projects/#{gpo_id}")
  end

  def project_attributes
    @project_attributes ||= Hashie::Mash.new(JSON.parse(response.read))
  end
end
