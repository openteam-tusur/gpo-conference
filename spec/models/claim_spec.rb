# == Schema Information
#
# Table name: claims
#
#  id         :integer          not null, primary key
#  chair_id   :integer
#  project_id :integer
#  user_id    :integer
#  role       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Claim do
  pending "add some examples to (or delete) #{__FILE__}"
end
