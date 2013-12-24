require "spec_helper"

describe Student do
  it_should_behave_like "a user"

  describe "attributes" do
    it { should have_many(:courses).through(:enrollments) }
  end
end
