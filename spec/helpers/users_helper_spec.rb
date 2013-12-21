require 'spec_helper'

describe UsersHelper do
  describe "full name" do
    let(:user) { FactoryGirl.create(:user) }
    it { expect(helper.full_name(user)).to eq("#{ user.first_name } "\
                                              "#{ user.last_name }") }
  end
end
