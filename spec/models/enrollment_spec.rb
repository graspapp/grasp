require 'spec_helper'

describe Enrollment do
  let(:enrollment) { FactoryGirl.create(:enrollment) }

  describe "attributes" do
    it { should belong_to :student }
    it { should belong_to :course }

    it { should validate_presence_of :student }
  end
end
