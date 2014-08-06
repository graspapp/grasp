require 'spec_helper'

describe Concept do
  it { should belong_to :unit }

  it { should have_many(:concept_progresses).dependent(:destroy) }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :dok1_resources}
  it { should respond_to :dok2_resources}
  it { should respond_to :dok3_resources}

  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
end
