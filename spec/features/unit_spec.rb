require 'spec_helper'

describe "Units" do

  before do

    teacher = FactoryGirl.create(:teacher)
    teacher.courses.build(name: "Algebra II")
    teacher.courses.first.units.build(name: "Basic Trig", number: "1.3.1")
    @unit = teacher.courses.first.units.first
  end


  subject { @unit }

  describe "attributes" do

    it { should belong_to  :course }
    it { should respond_to :name }
    it { should respond_to :number }
  end
end
