class Student < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :enrollments
  has_many :courses, through: :enrollments

  validates_presence_of :first_name, :last_name, :email, :password,
                        :password_confirmation, :class_code

  def full_name
    unless first_name.to_s.empty? and last_name.to_s.empty?
      [first_name, last_name].join(' ')
    end
  end

  def full_name=(name)
    parts = name.split(' ', 2)
    self.first_name = parts[0]
    self.last_name = parts[1]
  end
end
