require 'spec_helper'

describe ConceptProgress do
  it { should belong_to :enrollment }
  it { should belong_to :concept }

  it { should respond_to :type_of_error }
  it { should respond_to :next_steps }
  it { should respond_to :g_level }
  it { should respond_to :p_level }

  it { should validate_presence_of :type_of_error }
  it { should validate_presence_of :next_steps }
  it { should validate_presence_of :g_level }
  it { should validate_presence_of :p_level }
end
