require 'spec_helper'

describe ConceptProgress do
  it { should belong_to :enrollment }
  it { should belong_to :concept }

  it { should respond_to :type_of_error }
  it { should respond_to :next_steps }
  it { should respond_to :mastery_level }
  it { should respond_to :p_level }

  it { should validate_presence_of :type_of_error }
  it { should validate_presence_of :next_steps }
  it { should validate_presence_of :mastery_level }
  it { should validate_presence_of :p_level }

  describe "initial values" do
    let(:cp) { ConceptProgress.create }

    example { expect(cp.type_of_error).to eq "N/A" }
    example { expect(cp.next_steps).to eq "N/A" }
    example { expect(cp.mastery_level).to eq 1 }
    example { expect(cp.p_level).to eq 1 }
  end
end
