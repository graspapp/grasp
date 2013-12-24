class Course < ActiveRecord::Base
  before_validation :generate_course_code

  belongs_to :teacher

  validates :name, presence: true
  validates :course_code, presence: true

  private

  def generate_course_code
    self.course_code ||= SecureRandom.hex(3)
  end
end
