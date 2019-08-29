# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :read, User
    can :read, Comment
    return unless user

    can :manage, Comment, user_id: user.id
    can :manage, Apply, user_id: user.id
    can :manage, Project, user_id: user.id if user.role?
  end
end
