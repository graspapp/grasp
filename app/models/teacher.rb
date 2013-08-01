class Teacher < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :password_confirmation, :school, :city, :state, :country
  
    def full_name
        [first_name, last_name].join(' ')
    end
    
    def full_name=(name)
        parts = name.split(' ', 2)
        self.first_name = parts[0]
        self.last_name = parts[1]
    end
  
  
  
end
