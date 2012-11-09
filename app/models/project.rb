# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  gpo_id     :integer
#  theme_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :gpo_id, :theme_id

  belongs_to :theme

  validates_presence_of :theme

  delegate :analysis, :expected_results, :forecast, :funds_required, :funds_sources, :goal,
    :novelty, :purpose, :release_cost, :source_data, :stakeholders, :title, :participants, :project_managers,
    to: :project_attributes

  private

  def response
    @response ||= Curl.get("#{Settings['gpo.url']}/api/projects/#{gpo_id}")
  end

  def project_attributes
    @project_attributes ||= Hashie::Mash.new(JSON.parse(response.body_str))
  end
end
