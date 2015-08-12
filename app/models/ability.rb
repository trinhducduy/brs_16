class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
      cannot :create, Request
    else
      can :read, :all
      can [:create, :update], Request
      can [:create, :update, :destroy], Review, user_id: user.id
      can [:create, :update, :destroy], Comment, user_id: user.id
      can [:create, :destroy], Relationship, follower_id: user.id
      can [:create, :destroy], ActivityLike, user_id: user.id
      can [:create, :update, :destroy], UserBook, user_id: user.id
      can [:update, :destroy], User, id: user.id
    end
  end
end
