# encoding: utf-8
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

describe ProjectMemberClaim do
  describe 'try approve after create' do
    let(:user)          { Fabricate :user, last_name: 'Иванов', first_name: 'Иван' }
    let(:project)       { Fabricate :project }
    let(:role)          { nil }

    before { project.stub(:role_for).with(user).and_return role }

    def create_claim
      Fabricate :project_member_claim, user: user, project: project
    end

    context 'non member' do
      let(:managers) { [] }
      let(:participants) { [] }

      specify { expect { create_claim }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'member' do
      before { create_claim }

      context 'participant' do
        let(:role) { :participant }

        specify { user.should be_participant_of(project) }
      end

      context 'manager' do
        let(:role) { :manager }

        specify { user.should be_manager_of(project) }
      end
    end
  end
end
