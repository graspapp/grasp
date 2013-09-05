require 'spec_helper'

describe "LearningTarget detail view" do

  before { @lt = FactoryGirl.create(:learning_target) }

  subject { page }

  describe "when logged in as a teacher" do

    before do

      @teacher = add_learning_target(FactoryGirl.create(:teacher), @lt)
      sign_in @teacher
      visit learning_target_path(@lt)
    end

    it { should have_content(@lt.number) }
  end

  describe "when logged in as a student" do

    before do

      @student = add_learning_target(FactoryGirl.create(:student), @lt)
      sign_in @student
      visit learning_target_path(@lt)
    end

    it { should have_content(@lt.number) }
  end
end

def add_learning_target(model, lt)
  model.courses << FactoryGirl.create(:course)
  model.courses.last.units << FactoryGirl.create(:unit)
  model.courses.last.units.last.learning_targets << lt
  model
end
