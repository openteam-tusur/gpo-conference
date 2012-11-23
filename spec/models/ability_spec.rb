# encoding: utf-8

require 'spec_helper'

describe Ability do
  let(:conference)    { theme.conference }
  let(:theme)         { project.theme }
  let(:another_theme) { another_project.theme }

  let(:project) { Fabricate :project }
  let(:another_project) { Fabricate :project }

  let(:discourse) { project.discourses.new.tap{|d| d.save(:validate => false)} }
  let(:comment) { Comment.new }

  let(:rate) { discourse.rate_for(user) }

  subject { ability_for(user) }

  context 'administrator' do
    subject { ability_for(administrator) }
    it { should be_able_to(:manage, :all) }
  end

  context 'expert' do
    subject { ability_for(expert_of(theme, :user => user)) }

    it { should be_able_to(:create, comment) }
    it { should_not be_able_to(:manage, discourse) }

    context 'rates' do
      before { Timecop.freeze conference.hold_on.beginning_of_day }
      it { should be_able_to(:update, rate) }

      context 'of another theme' do
        subject { ability_for(expert_of(another_theme, :user => user)) }

        it { should_not be_able_to(:update, rate) }
      end

      context 'of another user' do
        subject { ability_for(another_expert_of(theme)) }

        it { should_not be_able_to(:update, rate) }
      end

      context 'before conference ends' do
        before { Timecop.freeze(conference.ends_on.end_of_day - 1.second) }
        it { should be_able_to(:update, rate) }
      end

      context 'before rating allowed' do
        before { Timecop.freeze(conference.hold_on.beginning_of_day - 1.second) }
        it { should_not be_able_to(:update, rate) }
      end

      context 'after rating allowed' do
        before { Timecop.freeze(conference.ends_on.end_of_day + 1.second) }
        it { should_not be_able_to(:update, rate) }
      end
    end
  end

  context 'manager' do
    before { user.permissions.create! :role => :manager, :context => project }

    it { should be_able_to(:create, comment) }
    it { should_not be_able_to(:update, rate) }
    it { should_not be_able_to(:manage, discourse) }
  end

  context 'participant' do
    before { user.permissions.create! :role => :participant, :context => project }

    it { should be_able_to(:create, comment) }
    it { should_not be_able_to(:update, rate) }
    context 'discourse' do
      before { Timecop.freeze(conference.starts_on.beginning_of_day) }
      it { should be_able_to(:manage, discourse) }
      it { should be_able_to(:manage, project.discourses.new) }
      it { should_not be_able_to(:manage, another_project.discourses.new) }

      context 'before discorce disallowed' do
        before { Timecop.freeze(conference.hold_on.beginning_of_day - 1.second) }
        it { should be_able_to(:manage, discourse) }
      end

      context 'before conference starts' do
        before { Timecop.freeze(conference.starts_on.beginning_of_day - 1.second) }
        it { should_not be_able_to(:manage, discourse) }
      end

      context 'after discourse disallowed' do
        before { Timecop.freeze(conference.hold_on.beginning_of_day) }
        it { should_not be_able_to(:manage, discourse) }
      end
    end
  end

  context 'authenticated' do
    it { should_not be_able_to(:create, comment) }
    it { should_not be_able_to(:update, rate) }
    it { should_not be_able_to(:manage, discourse) }
  end
end
