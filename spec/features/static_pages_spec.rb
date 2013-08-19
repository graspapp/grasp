require 'spec_helper'

describe 'static pages' do

  subject { page }

  describe 'home page' do

    before { visit root_path }

    it { should have_title('Grasp') }

  end

  describe 'help page' do

    before { visit help_path }

    it { should have_selector('h1', text: 'Help') }
    it { should have_title('Help | Grasp') }
  end

  describe 'about page' do

    before { visit about_path }

    it { should have_selector('h1', text: 'About') }
    it { should have_title('About | Grasp') }
  end

  describe 'contact page' do

    before { visit contact_path }

    it { should have_selector('h1', text: 'Contact') }
    it { should have_title('Contact | Grasp') }
  end

  describe 'acknowledgements page' do

    before { visit acknowledgements_path }

    it { should have_selector('h1', text: 'Acknowledgements') }
    it { should have_title('Acknowledgements | Grasp') }
  end

  it 'should have the right links on the layout' do

    visit root_path
    click_link 'About'
    page.should have_title(full_title('About'))
    click_link 'Acknowledgements'
    page.should have_title(full_title('Acknowledgements'))
    click_link 'Help'
    page.should have_title(full_title('Help'))
    click_link 'Contact'
    page.should have_title(full_title('Contact'))
    click_link 'Home'
    first(:link, 'Sign Up').click
  end
end
