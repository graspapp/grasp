class StudentsController < ApplicationController
  def home
    @student = current_user
  end
end
