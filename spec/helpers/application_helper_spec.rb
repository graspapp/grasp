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
  
  describe "negative_mastery" do
    it "should render NY for -1" do
      negative_mastery?(-1).should eq("NY")
    end
  end
end
