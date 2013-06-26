class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :role, :polymorphic => true

  validates_presence_of :first_name, :last_name, :email, :password, 
  						:password_confirmation
  validates_uniqueness_of :email

end
