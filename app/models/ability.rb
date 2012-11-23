# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :all if user.administrator?

    can :update, Rate do |rate|
      user.expert_of?(rate.theme) && rate.user == user
    end

    can :create, Comment if user.permissions.any?

    can :manage, Discourse do |discourse|
      user.participant_of?(discourse.project)
    end
  end
end
