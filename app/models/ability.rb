# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    if user.admin?
      can :manage, :all
    else
      can :read, Movie
    end
  end
end
