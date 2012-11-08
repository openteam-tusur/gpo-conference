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
