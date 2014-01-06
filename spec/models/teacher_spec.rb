require "spec_helper"

describe Teacher do
  it_should_behave_like "a user" do
    let(:user) { teacher }
  end

  it { should have_many(:courses).dependent(:destroy) }
end
