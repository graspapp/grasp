require 'spec_helper'

describe "static pages" do

  subject { page }
  
  describe "teacher home page" do
    
    before { visit root_path }
    
    describe "for signed in teachers" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      
      before do
        FactoryGirl.create(:course, teacher: teacher)
        sign_in teacher
        visit root_path
      end
      
      it "should render teacher's courses in tabs" do
        teacher.courses.each do |course|
          expect(page).to have_selector("li", text: course.name)
        end
      end
      
      it "should have a link to create a new course" do
        expect(page).to have_link("New Class")
      end
    end
    
    describe "creating a new class" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      
      before do
        sign_in teacher
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