class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all
    elsif user.role? :teacher
      can :manage, [Class, Student]
    elsif user.role? :student
      can :read, Class
      can :create, [Student, User]
    end
  end     
end
