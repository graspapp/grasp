require 'spec_helper'

describe Enrollment do
  let(:enrollment) { FactoryGirl.create(:enrollment) }

  describe "attributes" do
    it { should belong_to :student }
    it { should belong_to :course }
  end

  context "no student" do
    before { enrollment.student = nil }
    it { should_not be_valid }
  end
end
