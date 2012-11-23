# == Schema Information
#
# Table name: claims
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  user_id       :integer
#  role          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state         :string(255)
#  type          :string(255)
#  theme_id      :integer
#  conference_id :integer
#

require 'spec_helper'

describe ExpertClaim do
  subject                       { Fabricate :expert_claim }

  let(:theme)                   { subject.theme }
  let(:user)                    { subject.user }

  describe 'state_machine' do
    describe 'initial state' do
      before { subject.save }

      it { should be_pending }
      specify { user.should_not be_expert_of(theme) }
    end

    describe '#approve' do
      before { subject.approve }
      specify { user.should be_expert_of(theme) }
    end
  end

  describe '#destroy' do
    before { subject.approve }
    before { subject.destroy }

    specify { user.should_not be_expert_of(theme) }
  end
end
