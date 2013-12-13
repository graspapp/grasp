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

  context "contact" do
    before { visit contact_path }
    it { should have_content("Contact") }
    it { should have_title("Contact") }
  end

  context "acknowledgements" do
    before { visit acknowledgements_path }
    it { should have_content("Acknowledgements") }
    it { should have_title("Acknowledgements") }
  end
end
