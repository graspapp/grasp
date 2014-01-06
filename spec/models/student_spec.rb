require "spec_helper"

describe Student do
  it_should_behave_like "a user" do
    let(:user) { student }
  end

  it { should have_many(:enrollments).dependent(:destroy) }
  it { should have_many(:courses).through(:enrollments) }
end
