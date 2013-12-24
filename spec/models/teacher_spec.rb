require "spec_helper"

describe Teacher do
  let(:teacher) { FactoryGirl.create(:teacher) }

  it_should_behave_like "a user" do
    let(:user) { teacher }
  end

  describe "attributes" do
    it { should have_many :courses }
  end
end
