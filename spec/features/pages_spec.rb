require "spec_helper"

describe "Pages" do
  subject { page }

  context "root" do
    before { visit root_path }
    it { is_expected.to have_content("Grasp") }
    it { is_expected.to have_title("Grasp") }
  end

  context "about" do
    before { visit about_path }
    it { is_expected.to have_content("About") }
    it { is_expected.to have_title("About") }
  end

  context "acknowledgements" do
    before { visit acknowledgements_path }
    it { is_expected.to have_content("Acknowledgements") }
    it { is_expected.to have_title("Acknowledgements") }
  end

  context "learning" do
    before { visit tools_path }
    it { should have_content("Learning Tools") }
    it { should have_title("Learning Tools") }
  end
end
