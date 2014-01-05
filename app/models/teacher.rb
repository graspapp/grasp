class Teacher < User
  has_many :courses, dependent: :destroy
end
