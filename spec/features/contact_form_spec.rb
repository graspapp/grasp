require "spec_helper"

feature "Contact form" do
  before { visit contact_path }

  subject { page }

  describe "attributes" do
    it { is_expected.to have_content "Contact" }
    it { is_expected.to have_title "Contact" }
  end

  describe "sending an email" do
    context "with valid attributes" do
      let(:contact) { FactoryGirl.attributes_for(:contact) }
      before do
        fill_in "Name", with: contact[:name]
        fill_in "Email", with: contact[:email]
        fill_in "Subject", with: contact[:subject]
        fill_in "Message", with: contact[:message]
        click_button "Send"
      end

      it { is_expected.to have_content "sent successfully" }
    end

    context "with invalid attributes" do
      before { click_button "Send" }

      it { is_expected.to have_content "can't be blank" }
    end
  end
end
