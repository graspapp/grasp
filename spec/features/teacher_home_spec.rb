require 'spec_helper'

describe "Teacher home" do

  before do
    @teacher = FactoryGirl.create(:teacher, email: "teacher@email.com")
    sign_in @teacher
  end
  
  subject { page }
  
  describe "when courses do not exist" do
    
    it { should have_content("Uh oh") }
    
  end
    
  describe "creating a new course" do 
    
    it "should create a new course with the modal form" do
      
      click_link("create one")
      expect(page).to have_selector('h4', text:"Create Your Course")
      fill_in "Course name", with: "Pre-Calculus"
      
      expect { click_button "Create Course"}.to change(Course, :count).by(1)        end
  end
  
  describe "when courses exist" do
    
    before do 
      
      @course = FactoryGirl.create(:course, teacher: @teacher)
      visit root_path
    end
    
    it "should render teacher's courses in tabs" do
      @teacher.courses.each do |c|
        expect(page).to have_selector("li", text: c.name)
      end
    end
    
    it "should display each course's course code" do
      @teacher.courses.each do |c|
        should have_content(c.code)
      end
    end

    it "should have a button to add units" do
      should have_content("New Unit")
    end
  
    describe "when no units exist" do
    
      it { should have_content("Uh oh") }
    end
  
    describe "when units exist" do 
    
      before do
      
        @course.units.create(name: "Test Unit", number: "1.31")
        @unit = @course.units.last
        visit root_path
      end
    
      it { should have_content @unit.name }
      it { should have_content @unit.number }
    end
  end
end
  
