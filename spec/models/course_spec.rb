require 'spec_helper'

describe "Course" do

  before do
    teacher = FactoryGirl.create(:teacher)
    teacher.courses.build(name: "Algebra II")
    @course = teacher.courses.first
  end

  subject { @course }

  describe "attributes" do

    it { should belong_to  :teacher }
    it { should have_many(:students).through(:enrollments) }

    it { should respond_to :name }
    it { should respond_to :code }

    it "should include a non-blank course code" do

      @course.code.should_not be_empty
    end
  end

  describe "when name is blank" do
    
    before { @course.name = " " }
    it { should_not be_valid }
  end
end
