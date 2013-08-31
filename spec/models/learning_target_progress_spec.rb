require 'spec_helper'

describe LearningTargetProgress do

  before do
    @learning_target_progress = FactoryGirl.create(:learning_target_progress)
  end

  describe "attributes" do

    it { should respond_to :learning_target_id }
    it { should respond_to :level }
  end
end
