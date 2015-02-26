require "spec_helper"

describe ApplicationHelper do  
  describe "converting mastery level" do
    it "should render NY for -1" do
      expect(convert_mastery?(-1)).to eq("NY")
    end
    
    it "should render N for 0" do
      expect(convert_mastery?(0)).to eq("N")
    end
    
    it "should render value of positive integers" do
      number = rand 1..4
      expect(convert_mastery?(number)).to eq(number)
    end
  end
end
