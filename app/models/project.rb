class Project < ActiveRecord::Base
  attr_accessible :analysis, :expected_results, :features, :forecast, :funds_required,
    :funds_sources, :goal, :novelty, :purpose, :release_cost, :source_data, :stakeholders,
    :title, :gpo_id, :theme_id

  belongs_to :theme

  validates_presence_of :theme
end
