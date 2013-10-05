require 'spec_helper'

describe LearningTargetProgress do

  let (:ltp) { FactoryGirl.create(:learning_target_progress) }

  subject { ltp }

  describe "attributes" do

    it { should respond_to :concept_id }
    it { should respond_to :level }
    it { should belong_to  :enrollment }
    it { should belong_to  :concept}
    it { should have_many  :comments }
  end

  describe "with no level" do

    before { ltp.level = nil }
    it { should_not be_valid }
  end
end
