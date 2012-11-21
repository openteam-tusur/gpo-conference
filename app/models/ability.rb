# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application do
      user.permissions.any?
    end

    can :manage, :all if user.manager?

    # Заявки
    can [:create, :read], [ExpertClaim, ProjectMemberClaim]

    #can :manage, ExpertClaim do
      #user.manager?
    #end

    # Доклады
    can :read, Discourse if user.project_participant?

    #can :manage, Discourse do |discourse|
      #user.project_participant_of?(discourse.project)
    #end

    # Комментарии
    # Могут создавать пользователи с правами

    # Экспертные оценки
  end
end
