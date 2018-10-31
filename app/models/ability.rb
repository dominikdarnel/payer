class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Account, user_id: user.id
    can :manage, Transaction, from_user_id: user.id
    can :manage, Transaction, to_user_id: user.id
    can :manage, Card, user_id: user.id
  end
end
