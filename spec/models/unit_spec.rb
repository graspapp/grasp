require 'spec_helper'

describe "Units" do

  before do

    teacher = FactoryGirl.create(:teacher)
    teacher.courses.create(name: "Algebra II")
    teacher.courses.last.units.create(name: "Basic Trig", number: "1.3.1")
    @unit = teacher.courses.last.units.last
  end

  subject { @unit }

  describe "attributes" do

    it { should belong_to :course }
    it { should have_many(:concepts).dependent(:destroy)}
    it { should respond_to :name }
    it { should respond_to :number }
  end
end
