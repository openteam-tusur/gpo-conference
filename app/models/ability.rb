# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :all if user.administrator?

    can :update, Rate do |rate|
      user.expert_of?(rate.theme) &&
        rate.user == user &&
        (rate.conference.hold_on .. rate.conference.ends_on).include?(Date.today)
    end

    can :create, Comment if user.permissions.any?

    can :manage, Discourse do |discourse|
      user.participant_of?(discourse.project) &&
        (discourse.conference.starts_on .. (discourse.conference.hold_on - 1.day)).include?(Date.today)
    end
  end
end
