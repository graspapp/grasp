require 'spec_helper'

describe Concept do

  before do

    teacher = FactoryGirl.create(:teacher)
    course = FactoryGirl.create(:course)
    unit = FactoryGirl.create(:unit)
    @concept = FactoryGirl.create(:concept)

    teacher.courses << course
    course.units << unit
    unit.concepts << @concept
  end


  subject { @concept }

  describe "attributes" do

    it { should belong_to  :unit }
    it { should have_many  :concept_progresses}
    it { should respond_to :description}
    it { should respond_to :number }
  end
  
  describe "when description is blank" do
    before { @concept.description = "" }
    it { should_not be_valid }
  end
  
  describe "when number is blank" do
    before { @concept.number = "" }
    it { should_not be_valid }
  end
  
  describe "concept relationships" do
    
    before { @concept.save } 
    
    let!(:task1) { FactoryGirl.create(:task, concept: @concept) }
    let!(:task2) { FactoryGirl.create(:task, content: "Do something else.",
                                      concept: @concept) }   
    
    
    it "should destroy associated tasks" do
      tasks = @concept.tasks.to_a
      @concept.destroy
      expect(tasks).not_to be_empty
      tasks.each do |task|
        expect(Task.where(id: task.id)).to be_empty
      end
    end 
  end
end
