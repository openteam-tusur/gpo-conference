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

Fabricator(:project) do
  analysis         "MyText"
  expected_results "MyText"
  features         "MyText"
  forecast         "MyText"
  funds_required   "MyText"
  funds_sources    "MyText"
  goal             "MyText"
  novelty          "MyText"
  purpose          "MyText"
  release_cost     "MyText"
  source_data      "MyText"
  stakeholders     "MyText"
  title            "MyString"
end
