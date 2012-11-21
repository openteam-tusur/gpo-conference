# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    ## common
    can :manage, Context do | context |
      user.manager_of? context
    end

    can :manage, Permission do | permission |
      permission.context && user.manager_of?(permission.context)
    end

    can [:new, :create], Permission do | permission |
      !permission.context && user.manager?
    end

    can [:search, :index], User do
      user.manager?
    end

    can :manage, :application do
      user.permissions.any?
    end

    can :manage, :permissions do
      user.manager?
    end

    can :manage, :audits do
      user.manager_of? Context.first
    end

    ## app specific
    can :manage, Subcontext do | subcontext |
      user.manager_of? subcontext.context
    end

    can :manage, Subcontext do | subcontext |
      user.manager_of? subcontext
    end

    # Заявки
    can :new, Claim
    can [:new, :create, :show], [ExpertClaim, ProjectMemberClaim]

    can :manage, ExpertClaim do
      user.manager?
    end

    # Доклады
    can :manage, Discourse do |discourse|
      user.project_participant_of? discourse.project
    end

    # Комментарии
    # Экспертные оценки
  end
end
