require 'spec_helper'

describe "teacher pages" do

  before do
    @teacher = FactoryGirl.create(:teacher)
    sign_in @teacher
  end
  
  subject { page }
  
  describe "home page" do
    
    before { visit root_path }
    
    describe "with a course" do
      
      before do
        FactoryGirl.create(:course, teacher: @teacher)
        visit root_path
      end
    
      describe "for signed in @teachers" do

        it "should render @teacher's courses in tabs" do
          @teacher.courses.each do |course|
            expect(page).to have_selector("li", text: course.name)
          end
        end
      end
    end
    
    describe "with no courses" do
      
      it { should have_content("Uh oh") }
    end
    
    describe "creating a new course" do

      describe "when a course does not already exist" do

        it "should open modal create course form" do
          click_link("add one")
          expect(page).to have_selector('h4', text:"Create Your Course")
        end
      
        it "should create a new course" do
          click_link("add one")
          fill_in "Course name", with: "Pre-Calculus"
        
          expect { click_button "Continue" }.to change(Course, :count).by(1)
        end
      end

      describe "when a course already exists" do
      
        before do
          FactoryGirl.create(:course, teacher: @teacher)
          visit root_path
        end
      
        it "should open modal create course form" do
          click_link("New Class")
          expect(page).to have_selector('h4', text:"Create Your Course")
        end
      
        it "should create a new course" do
          click_link("New Class")
          fill_in "Course name",    with: "Pre-Calculus"
        
          expect { click_button "Continue" }.to change(Course, :count).by(1)
        end
      end
    end 
  end
end
