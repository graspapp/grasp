class Course < ActiveRecord::Base
  before_validation :generate_course_code

  belongs_to :teacher
  has_many :units

  has_many :enrollments
  has_many :students, through: :enrollments

  validates :name, presence: true
  validates :course_code, presence: true, uniqueness: true

  private

  def generate_course_code
    code = SecureRandom.hex(3)
    if Course.find_by_course_code(code) != nil
      generate_course_code
    else
      self.course_code ||= code
    end
  end
end
