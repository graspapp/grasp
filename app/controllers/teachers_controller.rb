class TeachersController < ApplicationController
  def home
    @teacher = current_user
  end
end
