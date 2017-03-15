class Ability
  include CanCan::Ability

  # CanCanCan will automatically initialize this class for you with every
  # request, so you don't have to instantiate the class yourself. CanCanCan
  # exepct that you have a method defined called `current_user` that will return
  # the user object of the currently signed in user or `nil` if the user is not
  # signed in.
  def initialize(user)

    # this will insantiate the `user` variable to a new `User` object if it's
    # nil or undefined
    user ||= User.new

    # this gives super powers to the admin. The admin here can do anything
    if user.is_admin?
      can :manage, :all
    end


    can :manage, Post do |post|
      post.user == user
    end

      can :manage, Comment do |comment|
        comment.user == user || comment.post.user == user
    end

    cannot :like, Post do |p|
      user == p.user
    end

    can :like, Post do |p|
      user != p.user
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
