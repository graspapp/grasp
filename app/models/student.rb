class Student < User
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
end
