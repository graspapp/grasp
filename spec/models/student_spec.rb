require "spec_helper"

describe Student do
  let(:student) { FactoryGirl.create(:student) }

  it_should_behave_like "a user" do
    let(:user) { student }
  end

  describe "attributes" do
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:courses).through(:enrollments) }
  end
end
