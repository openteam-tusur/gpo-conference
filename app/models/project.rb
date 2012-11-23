# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  gpo_id     :integer
#  theme_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#  chair_id   :integer
#  cipher     :string(255)
#

class Project < ActiveRecord::Base
  attr_accessible :chair_id, :cipher, :gpo_id, :title, :theme_id

  belongs_to :chair
  belongs_to :theme

  has_many :discourses
  has_many :permissions, :foreign_key => :context_id
  has_many :users, :through => :permissions
  has_many :project_members, :through => :permissions, :source => :user, :conditions => { 'permissions.role' => :participant }
  has_one  :conference, :through => :theme

  validates_presence_of :chair, :gpo_id, :theme

  delegate :analysis, :expected_results, :forecast, :funds_required, :funds_sources, :goal,
    :novelty, :purpose, :release_cost, :source_data, :stakeholders, :participants, :managers,
    to: :project_attributes

  delegate :abbr, :to => :chair, :prefix => true

  scope :ordered_by_title, :order => [:chair_id, :title]

  scope :for_current_conference, -> { joins(:theme).where(:themes => { :conference_id => Conference.current }) }

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

  private

  def member?(role, user)
    self.send(role.to_s.pluralize).each do |member|
      return true if member.last_name == user.last_name &&
        member.first_name == user.first_name
    end

    false
  end

  def response
    @response ||= Curl.get("#{Settings['gpo.url']}/api/projects/#{gpo_id}")
  end

  def project_attributes
    @project_attributes ||= Hashie::Mash.new(JSON.parse(response.body_str))
  end
end
