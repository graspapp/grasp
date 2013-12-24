require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  it_should_behave_like "a user"
end
