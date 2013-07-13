require 'spec_helper'

describe "Learning targets" do

  before do

    teacher = FactoryGirl.create(:teacher)
    teacher.courses.build(name: "Algebra II")
    teacher.courses.first.units.build(name: "Basic Trig", number: "1.3.1")
    teacher.courses.first.units.first.learning_targets.build
    @learning_target = teacher.courses.first.units.first.learning_targets.first
  end


  subject { @learning_target }

  describe "attributes" do

    it { should belong_to  :unit }
  end
end
