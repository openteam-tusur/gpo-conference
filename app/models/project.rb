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

  validates_presence_of :chair, :gpo_id, :theme

  delegate :analysis, :expected_results, :forecast, :funds_required, :funds_sources, :goal,
    :novelty, :purpose, :release_cost, :source_data, :stakeholders, :participants, :project_managers,
    to: :project_attributes

  scope :ordered_by_title, :order => [:chair_id, :title]

  def complex_title
    "#{cipher} #{title}"
  end

  def has_participant?(user)
    participants.each do |participant|
      return true if participant.last_name == user.last_name &&
        participant.first_name == user.first_name
    end

    false
  end

  def has_manager?(user)
    project_managers.each do |project_manager|
      return true if project_manager.last_name == user.last_name &&
        project_manager.first_name == user.first_name
    end

    false
  end

  def to_s
    "#{cipher} #{title}"
  end

  private

  def response
    @response ||= Curl.get("#{Settings['gpo.url']}/api/projects/#{gpo_id}")
  end

  def project_attributes
    @project_attributes ||= Hashie::Mash.new(JSON.parse(response.body_str))
  end
end
