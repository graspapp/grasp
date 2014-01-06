require 'spec_helper'

describe Concept do
  it { should belong_to :unit }
  it { should respond_to :number }
  it { should respond_to :description }

  it { should validate_presence_of :number }
  it { should validate_presence_of :description }
end
