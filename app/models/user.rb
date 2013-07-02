class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :roles

  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation


     def role?(role)
      return !!self.roles.find_by_name(role.to_s)
    end 	

end
