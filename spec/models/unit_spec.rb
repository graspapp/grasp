require 'spec_helper'

describe Unit do
  let(:unit) { FactoryGirl.create(:unit) }

  describe "attributes" do
    it { should belong_to :course }
    it { should respond_to :name }
    it { should respond_to :number }

    it { should validate_presence_of :name }
    it { should validate_presence_of :number }
  end
end
