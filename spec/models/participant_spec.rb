# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  project_id :integer
#  course     :integer
#  edu_group  :string(255)
#  email      :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  mid_name   :string(255)
#  gpo_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Participant do
  pending "add some examples to (or delete) #{__FILE__}"
end
