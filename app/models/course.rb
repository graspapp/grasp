class Course < ActiveRecord::Base

  after_initialize :init

  belongs_to :teacher

  has_many :units
  has_many :enrollments
  has_many :students, through: :enrollments

  validates_presence_of :name, :code

  def init
    self.code ||= generate_course_code
  end

  def generate_course_code
    SecureRandom.base64(6).gsub(/=+$/,'')
  end

  def to_s
    name.downcase.gsub ' ', '_'
  end
end
