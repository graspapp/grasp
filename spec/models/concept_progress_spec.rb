require 'spec_helper'

describe ConceptProgress do
  it { is_expected.to belong_to :enrollment }
  it { is_expected.to belong_to :concept }

  it { is_expected.to be_versioned }

  it { is_expected.to respond_to :type_of_error }
  it { is_expected.to respond_to :next_steps }
  it { is_expected.to respond_to :mastery_level }
  it { is_expected.to respond_to :goal_level }
  it { is_expected.to respond_to :effort }
  it { is_expected.to respond_to :note_taking }
  it { is_expected.to respond_to :studying }

  it { is_expected.to validate_presence_of :type_of_error }
  it { is_expected.to validate_presence_of :next_steps }
  it { is_expected.to validate_presence_of :mastery_level }
  it { is_expected.to validate_presence_of :goal_level }
  it { is_expected.to validate_presence_of :effort }
  it { is_expected.to validate_presence_of :note_taking }
  it { is_expected.to validate_presence_of :studying }

  it { is_expected.to ensure_length_of(:action_steps).is_at_most(140) }
  it { is_expected.to ensure_inclusion_of(:type_of_error).in_array(%w(N/A Procedural
    Conceptual Misconception No\ Error)) }
  it { is_expected.to ensure_inclusion_of(:mastery_level).in_range(0..4) }
  it { is_expected.to ensure_inclusion_of(:goal_level).in_range(1..4) }
  it { is_expected.to ensure_inclusion_of(:effort).in_range(1..4) }
  it { is_expected.to ensure_inclusion_of(:note_taking).in_range(1..4) }
  it { is_expected.to ensure_inclusion_of(:studying).in_range(1..4) }

  describe "initial values" do
    let(:cp) { ConceptProgress.create }

    example { expect(cp.type_of_error).to eq "N/A" }
    example { expect(cp.next_steps).to eq "N/A" }
    example { expect(cp.mastery_level).to eq 0 }
    example { expect(cp.goal_level).to eq 1 }
    example { expect(cp.effort).to eq 1 }
    example { expect(cp.note_taking).to eq 1 }
    example { expect(cp.studying).to eq 1 } 
  end
end
