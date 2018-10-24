class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :manage, Account, user_id: user.id
      can :manage, Transaction #, user_id: user.id
      can :manage, Card, user_id: user.id
    end
  end
end
