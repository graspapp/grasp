class TeachersController < ApplicationController
  def home
    @teacher = current_teacher
  end
end
