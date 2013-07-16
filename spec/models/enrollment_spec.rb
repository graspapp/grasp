require 'spec_helper'

describe "Enrollment" do
	before do
		@enrollment = Enrollment.new;
	end

	subject { @enrollment }

  it { should belong_to :course }
  it { should belong_to :student }
end
