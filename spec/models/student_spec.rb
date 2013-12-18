require "spec_helper"

describe Student do
  before { @student = FactoryGirl.create(:student) }

  describe "attributes" do
    it { should have_one(:user).dependent(:destroy) }
    it { should accept_nested_attributes_for(:user) }
  end
end
