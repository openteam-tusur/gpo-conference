require 'spec_helper'

describe ExpertClaim do
  describe 'state_machine' do
    subject { Fabricate :expert_claim }

    describe 'initial state' do
      it { should be_pending }
    end

    describe 'transition :pending => :approve should create permissions' do
      let(:theme)             { subject.theme }
      let(:user)              { subject.user }
      let(:expert_permission) { user.permissions.where(context_type: 'Theme', context_id: theme.id, role: :expert).first }
      let(:member_permission) { user.permissions.where(context_type: 'Context', context_id: Context.root.id, role: :participant).first }

      before { subject.approve }

      specify { expert_permission.should be_persisted }
      specify { member_permission.should be_persisted }
    end
  end
end
