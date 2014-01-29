require 'spec_helper'

describe ConceptProgress do
  it { should belong_to :enrollment }
  it { should belong_to :concept }

  it { should be_versioned }

  it { should respond_to :type_of_error }
  it { should respond_to :next_steps }
  it { should respond_to :mastery_level }
  it { should respond_to :goal_level }
  it { should respond_to :completed }

  it { should validate_presence_of :type_of_error }
  it { should validate_presence_of :next_steps }
  it { should validate_presence_of :mastery_level }
  it { should validate_presence_of :goal_level }

  it { should ensure_length_of(:action_steps).is_at_most(140) }
  it { should ensure_inclusion_of(:type_of_error).in_array(%w(N/A Procedural
    Conceptual Misconception No\ Error)) }
  it { should ensure_inclusion_of(:mastery_level).in_range(-1..4) }
  it { should ensure_inclusion_of(:goal_level).in_range(1..4) }

  describe "initial values" do
    let(:cp) { ConceptProgress.create }

    example { expect(cp.type_of_error).to eq "N/A" }
    example { expect(cp.next_steps).to eq "N/A" }
    example { expect(cp.mastery_level).to eq 0 }
    example { expect(cp.goal_level).to eq 1 }
    example { expect(cp.completed).to eq false }    
  end
end
