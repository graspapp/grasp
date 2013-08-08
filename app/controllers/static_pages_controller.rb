class StaticPagesController < ApplicationController
  def home
    if teacher_signed_in?
      @courses = current_teacher.courses
      @course = current_teacher.courses.build
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
