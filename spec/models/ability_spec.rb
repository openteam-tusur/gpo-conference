# encoding: utf-8

require 'spec_helper'

describe Ability do
  let(:theme) { project.theme }
  let(:another_theme) { another_project.theme }

  let(:project) { Fabricate :project }
  let(:another_project) { Fabricate :project }

  let(:discourse) { project.discourses.new.tap{|d| d.save(:validate => false)} }

  let(:rate) { discourse.rate_for(expert_of(theme)) }

  context 'administrator' do
    subject { ability_for(administrator) }
    it { should be_able_to(:manage, :all) }
  end

  context 'expert' do
    subject { ability_for(expert_of(theme)) }
    context 'rates' do
      it { should be_able_to(:manage, rate) }
      context 'of another project' do
        subject { ability_for(expert_of(another_theme)) }
        it { should_not be_able_to(:manage, rate) }
      end
      context 'of another user' do
        subject { ability_for(another_expert_of(theme)) }
        it { should_not be_able_to(:manage, rate) }
      end
    end
  end
end
