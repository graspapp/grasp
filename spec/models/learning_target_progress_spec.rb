require 'spec_helper'

describe LearningTargetProgress do

  let (:ltp) { FactoryGirl.create(:learning_target_progress) }

  subject { ltp }

  describe "attributes" do

    it { should respond_to :learning_target_id }
    it { should respond_to :level }
    it { should belong_to  :enrollment }
    it { should belong_to  :learning_target }
  end

  describe "with no level" do

    before { ltp.level = nil }
    it { should_not be_valid }
  end
end
