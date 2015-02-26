require 'spec_helper'

describe Concept do
  it { is_expected.to belong_to :unit }

  it { is_expected.to have_many(:concept_progresses).dependent(:destroy) }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :description }
  it { is_expected.to respond_to :dok1_resources}
  it { is_expected.to respond_to :dok2_resources}
  it { is_expected.to respond_to :dok3_resources}

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
end
