require 'spec_helper'

describe "static pages" do

  subject { page }

  describe "home page" do

    before { visit root_path }

    it { should have_selector('h1', text: 'Grasp') }
    it { should have_title('Grasp') }
  end

  describe "help page" do
    
    before { visit help_path }

    it { should have_selector('h1', text: 'Help') }
    it { should have_title('Help | Grasp') }
  end

  describe "about page" do
    
    before { visit about_path }

    it { should have_selector('h1', text: 'About') }
    it { should have_title('About | Grasp') }
  end

  describe "contact page" do
    
    before { visit contact_path }

    it { should have_selector('h1', text: 'Contact') }
    it { should have_title('Contact | Grasp') }
  end
end
