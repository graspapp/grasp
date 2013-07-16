class Student < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :courses, through: :nrollments

  validates_presence_of :first_name, :last_name, :email, :password,
                        :password_confirmation, :class_code
end
