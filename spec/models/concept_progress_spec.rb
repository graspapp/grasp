require 'spec_helper'

describe ConceptProgress do

  let (:cp) { FactoryGirl.create(:concept_progress) }

  subject { cp }

  describe "attributes" do

    it { should respond_to :concept_id }
    it { should respond_to :level }
    it { should belong_to  :enrollment }
    it { should belong_to  :concept}
    it { should have_many  :comments }
  end

  describe "with no level" do

    before { cp.level = nil }
    it { should_not be_valid }
  end
end
