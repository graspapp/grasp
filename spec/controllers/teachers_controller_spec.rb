require "spec_helper"

describe TeachersController do
  let(:teacher) { FactoryGirl.create(:teacher) }
  before(:each) { login_user teacher }

  describe "GET root path" do
    before { get :home }

    example { expect(assigns(:teacher)).to eq teacher }
    example { expect(assigns(:course)).to be_instance_of Course }
  end
end
