require 'spec_helper'

describe Unit do
  it { is_expected.to belong_to :course }
  it { is_expected.to have_many(:concepts).dependent(:destroy) }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :number }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :number }
end
