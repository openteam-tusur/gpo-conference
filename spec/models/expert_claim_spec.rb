require 'spec_helper'

describe ExpertClaim do
  describe 'state_machine' do
    describe 'initial state' do
      subject { Fabricate :expert_claim }

      it { should be_pending }
    end
  end

  describe 'should create permissions after create' do
    let(:expert_claim)      { Fabricate :expert_claim }
    let(:theme)             { expert_claim.theme }
    let(:user)              { expert_claim.user }
    let(:expert_permission) { user.permissions.where(context_type: 'Theme', context_id: theme.id, role: :expert).first }

    specify { expert_permission.should be_persisted }
  end
end
