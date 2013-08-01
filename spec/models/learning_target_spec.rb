require 'spec_helper'

describe "Learning targets" do

  before do

    teacher = FactoryGirl.create(:teacher)
    teacher.courses.build(name: "Algebra II")
    teacher.courses.first.units.build(name: "Basic Trig", number: "1.3.1")
    teacher.courses.first.units.first.learning_targets.build(name: "Explain concept...", number: "1A")
    @learning_target = teacher.courses.first.units.first.learning_targets.first
  end


  subject { @learning_target }

  describe "attributes" do

    it { should belong_to  :unit }
    it { should respond_to :name }
    it { should respond_to :number }
  end
  
  describe "when name is blank" do
    before { @learning_target.name = "" }
    it { should_not be_valid }
  end
  
  describe "when number is blank" do
    before { @learning_target.number = "" }
    it { should_not be_valid }
  end
  
  describe "learning target relationships" do
    
    before { @learning_target.save } 
    
    let!(:task1) { FactoryGirl.create(:task, learning_target: @learning_target) }
    let!(:task2) { FactoryGirl.create(:task, content: "Do something else.", learning_target: @learning_target) }   
    
    
    it "should destroy associated tasks" do
      tasks = @learning_target.tasks.to_a
      @learning_target.destroy
      expect(tasks).not_to be_empty
      tasks.each do |task|
        expect(Task.where(id: task.id)).to be_empty
      end
    end 
  end
end
