require 'spec_helper'

describe ExpertClaim do
  subject                       { Fabricate :expert_claim }

  let(:theme)                   { subject.theme }
  let(:user)                    { subject.user }
  let(:expert_permission)       { user.permissions.where(context_type: 'Theme', context_id: theme.id, role: :expert).first }
  let(:participant_permission)  { user.participant_permission }

  describe 'state_machine' do
    describe 'initial state' do
      it { should be_pending }
    end

    describe 'transition :pending => :approve should create permissions' do
      before { subject.approve }

      specify { participant_permission.should be_persisted }
      specify { expert_permission.should be_persisted }
    end
  end

  describe 'after destroy' do
    describe 'should destroy permissions' do
      before { subject.approve }

      context 'expert for one theme' do
        before { subject.destroy }

        specify { user.participant_permission.should_not be_persisted }
        specify { expert_permission.should be_nil }
      end

      context 'expert for few themes' do
        let(:anoterh_claim) { Fabricate :expert_claim, user: user }

        before { anoterh_claim.approve }
        before { subject.destroy }

        specify { user.participant_permission.should be_persisted }
      end
    end
  end
end
