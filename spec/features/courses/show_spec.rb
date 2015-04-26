require "spec_helper"

describe "Course show" do
  let(:course) { FactoryGirl.create(:course_with_units, units_count: 1) }
  before(:each) do
    user.courses << course

    login_as(user, scope: :user)
    visit course_path(course)
  end

  subject { page }

  shared_examples_for "a course show page" do
    it { is_expected.to have_content course.name }
    it { is_expected.to have_title course.name }

    describe "unit attributes" do
      let(:unit) { course.units.first }

      it { is_expected.to have_content unit.number }
      it { is_expected.to have_content unit.name }

      describe "when unit isn't in current course" do
        let(:unit) { FactoryGirl.create(:unit) }
        before do
          user.courses << unit.course
          visit current_path
        end

        it { is_expected.not_to have_content unit.number }
        it { is_expected.not_to have_content unit.name }
      end
    end
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it_should_behave_like "a course show page"

    it { is_expected.not_to have_button "Leave Course" }

    describe "creating unit" do
      let(:attrs) { FactoryGirl.attributes_for(:unit) }
      before do
        click_link "Create Unit"

        fill_in "Number", with: attrs[:number]
        fill_in "Name", with: attrs[:name]
        click_button "Create Unit"
      end

      it { is_expected.to have_content attrs[:number] }
      it { is_expected.to have_content attrs[:name] }
    end

    describe "editing unit" do
      let(:attrs) { FactoryGirl.attributes_for(:unit) }
      before do
        first(:link, "Edit").click
        fill_in "Number", with: attrs[:number]
        fill_in "Name", with: attrs[:name]
        click_button "Update Unit"
      end

      it { is_expected.to have_content attrs[:number] }
      it { is_expected.to have_content attrs[:name] }
    end
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }

    it_should_behave_like "a course show page"

    it { is_expected.not_to have_link "Create Unit" }

    # example "leaving course" do
#       expect {
#         click_button "Leave Course"
#       }.to change(user.courses, :count).by -1
#     end
  end
end
