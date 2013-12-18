require 'spec_helper'

describe UsersHelper do
  describe "full name" do
    before { @user = FactoryGirl.create(:user) }
    it { expect(helper.full_name(@user)).to eq("Foo Bar") }
  end
end
