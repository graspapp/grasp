require 'spec_helper'

describe ConceptsController do

  it "should make sure you are signed in for access" do
    visit "/concepts/1"
    page.should have_content "You need to sign in or sign up before continuing."
  end
end
