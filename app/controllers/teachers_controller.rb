class TeachersController < ApplicationController
  def home
    @teacher = current_teacher
    @course = @teacher.courses.build
  end
end
