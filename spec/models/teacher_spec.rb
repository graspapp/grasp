require "spec_helper"

describe Teacher do
  before { @teacher = FactoryGirl.create(:teacher) }

  describe "attributes" do
    it { should have_one(:user).dependent(:destroy) }
    it { should accept_nested_attributes_for(:user) }
  end
end
