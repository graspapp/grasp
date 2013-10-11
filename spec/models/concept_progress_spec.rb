require 'spec_helper'

describe ConceptProgress do

  let (:cp) { FactoryGirl.create(:concept_progress) }

  subject { cp }

  describe "attributes" do

    it { should belong_to  :enrollment }
    it { should belong_to  :concept}

    it { should respond_to :enrollment_id }
    it { should respond_to :concept_id }

    it { should respond_to :level }
    it { should respond_to :type_of_error }
    it { should respond_to :next_steps }
  end

  describe "with no level" do

    before { cp.level = nil }
    it { should_not be_valid }
  end

  describe "with no type of error" do

    before { cp.type_of_error = nil }
    it { should_not be_valid }
  end

  describe "with no next steps" do

    before { cp.next_steps = nil }
    it { should_not be_valid }
  end
end
