require 'spec_helper'

describe "Unit home" do

  before do
    
    teacher = FactoryGirl.create(:teacher)
    teacher.courses << FactoryGirl.create(:course)
    teacher.courses.last.units << FactoryGirl.create(:unit)
    @unit = teacher.courses.last.units.last

    sign_in teacher
    visit unit_path(@unit)
  end

  subject { page }

  it "should have the unit's name as the page title" do
    should have_title(@unit.name)
  end
end
