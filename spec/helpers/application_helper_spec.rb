require "spec_helper"

describe ApplicationHelper do
  describe "yes_or_no" do
    
    it "should render Yes for true" do
      yes_or_no(true).should eq("Yes")
    end
    
    it "should render No for false" do
      yes_or_no(false).should eq("No")
    end
  end
  
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
