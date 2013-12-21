require 'spec_helper'

describe User do
  before { @user = FactoryGirl.create(:user) }

  subject { @user }

  it_should_behave_like "a user"
end
