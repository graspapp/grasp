require 'spec_helper'

describe "Tasks" do
  before do
    teacher = FactoryGirl.create(:teacher)
    teacher.courses.build(name: "Algebra II")
    teacher.courses.first.units.build(name: "Basic Trig", number: "1.3.1")
    teacher.courses.first.units.first.learning_targets.build(name: "Explain concept...", number: "1A")
    @task = teacher.courses.first.units.first.learning_targets.first.tasks.build(status: "Incomplete", content: "Solve for...")
  end
  
  subject { @task }
  
  describe "attributes" do
    
    it { should belong_to :learning_target }
    it { should respond_to :status }
    it { should respond_to :content}
  end
  
  describe "when status is blank" do
    before { @task.status = "" }
    it { should_not be_valid }
  end
  
  describe "when content is blank" do
    before { @task.content = "" }
    it { should_not be_valid }
  end
end
