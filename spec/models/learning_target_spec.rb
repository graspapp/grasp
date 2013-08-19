require 'spec_helper'

describe "Learning targets" do

  before do

    teacher = FactoryGirl.create(:teacher)
    course = FactoryGirl.create(:course)
    unit = FactoryGirl.create(:unit)
    @learning_target = FactoryGirl.create(:learning_target)

    teacher.courses << course
    course.units << unit
    unit.learning_targets << @learning_target
  end


  subject { @learning_target }

  describe "attributes" do

    it { should belong_to  :unit }
    it { should respond_to :description}
    it { should respond_to :number }
  end
  
  describe "when description is blank" do
    before { @learning_target.description = "" }
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
