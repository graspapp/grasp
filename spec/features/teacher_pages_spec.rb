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
  end
end