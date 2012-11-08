# == Schema Information
#
# Table name: projects
#
#  id               :integer          not null, primary key
#  analysis         :text
#  expected_results :text
#  features         :text
#  forecast         :text
#  funds_required   :text
#  funds_sources    :text
#  goal             :text
#  novelty          :text
#  purpose          :text
#  release_cost     :text
#  source_data      :text
#  stakeholders     :text
#  title            :string(255)
#  gpo_id           :integer
#  theme_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :analysis, :expected_results, :features, :forecast, :funds_required,
    :funds_sources, :goal, :novelty, :purpose, :release_cost, :source_data, :stakeholders,
    :title, :gpo_id, :theme_id

  belongs_to :theme

  has_many :managers
  has_many :participants

  validates_presence_of :theme
end
