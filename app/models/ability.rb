# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    return unless user

    can :manage, Project, user_id: user.id
  end
end
