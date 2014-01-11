class Course < ActiveRecord::Base
  before_validation :generate_course_code

  belongs_to :teacher
  has_many :units, dependent: :destroy

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  validates_presence_of :name, :course_code
  validates_uniqueness_of :course_code

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
