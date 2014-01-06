require 'spec_helper'

describe Unit do
  it { should belong_to :course }
  it { should have_many(:concepts).dependent(:destroy) }
  it { should respond_to :name }
  it { should respond_to :number }

  it { should validate_presence_of :name }
  it { should validate_presence_of :number }
end
