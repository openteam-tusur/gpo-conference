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

    #can :manage, :application do
      #user.permissions.any?
    #end

    #can :manage, :all if user.manager?

    # Заявки
    #can [:create, :read], [ExpertClaim, ProjectMemberClaim]

    #can :manage, ExpertClaim do
      #user.manager?
    #end

    # Доклады

    #can :manage, Discourse do |discourse|
      #user.participant_of?(discourse.project)
    #end

    # Комментарии
    # Могут создавать пользователи с правами

    # Экспертные оценки
  end
end
