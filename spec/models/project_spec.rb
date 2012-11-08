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

require 'spec_helper'

describe Project do
  pending "add some examples to (or delete) #{__FILE__}"
end
