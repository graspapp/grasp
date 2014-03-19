require "spec_helper"

describe ApplicationHelper do  
  describe "converting mastery level" do
    it "should render NY for -1" do
      convert_mastery?(-1).should eq("NY")
    end
    
    it "should render N for 0" do
      convert_mastery?(0).should eq("N")
    end
    
    it "should render value of positive integers" do
      number = rand 1..4
      convert_mastery?(number).should eq(number)
    end
  end
end
