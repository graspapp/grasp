require "spec_helper"

describe "Pages" do
  subject { page }

  context "root" do
    before { visit root_path }
    it { should have_content("Grasp") }
    it { should have_title("Grasp") }
  end

  context "about" do
    before { visit about_path }
    it { should have_content("About") }
    it { should have_title("About") }
  end

  context "acknowledgements" do
    before { visit acknowledgements_path }
    it { should have_content("Acknowledgements") }
    it { should have_title("Acknowledgements") }
  end

  context "learning" do
    before { visit tools_path }
    it { should have_content("Learning Tools") }
    it { should have_title("Learning Tools") }
  end
end
