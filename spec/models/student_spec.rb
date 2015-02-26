require "spec_helper"

describe Student do
  it_should_behave_like "a user" do
    let(:user) { student }
  end

  it { is_expected.to have_many(:enrollments).dependent(:destroy) }
  it { is_expected.to have_many(:courses).through(:enrollments) }
end
