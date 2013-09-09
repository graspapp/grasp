require 'spec_helper'

describe Comment do
  let (:comment) { FactoryGirl.create(:comment) }
  
  subject { comment }
   
  describe "attributes" do
    
    it { should respond_to :content }
    it { should belong_to :learning_target_progress }
  end
  
  describe "with no content" do
    before {comment.content = nil }
    it { should_not be_valid }
  end
  
  describe "with no commenter name" do
    before { comment.commenter_name = nil }
    it { should_not be_valid }
  end
end
