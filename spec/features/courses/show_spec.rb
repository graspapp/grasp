require "spec_helper"

describe "Course show" do
  let(:course) { FactoryGirl.create(:course) }
  before(:each) do
    user.courses << course

    login_as(user, scope: :user)
    visit course_path(course)
  end

  subject { page }

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it { should_not have_button "Leave Course" }

    describe "creating unit" do
      let(:unit) { FactoryGirl.attributes_for(:unit) }
      before do
        click_link "Create Unit"

        fill_in "Number", with: unit[:number]
        fill_in "Name", with: unit[:name]
        click_button "Create Unit"
      end

      it { should have_content unit[:number] }
      it { should have_content unit[:name] }
    end

    describe "editing unit" do
      let(:unit) { FactoryGirl.attributes_for(:unit) }
      before do
        course.units << FactoryGirl.create(:unit)
        visit current_path

        click_link "Edit"
        fill_in "Number", with: unit[:number]
        fill_in "Name", with: unit[:name]
        click_button "Update Unit"
      end

      it { should have_content unit[:number] }
      it { should have_content unit[:name] }
    end
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }

    it { should_not have_link "Create Unit" }

    example "leaving course" do
      expect {
        click_button "Leave Course"
      }.to change(user.courses, :count).by -1
    end
  end
end
