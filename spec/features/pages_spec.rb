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
  
  context "acem" do
    before { visit acem_path }
    it { is_expected.to have_content("ACE-M Tool") }
    it { is_expected.to have_title("ACE-M Tool") }
  end
end
