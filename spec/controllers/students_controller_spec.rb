require "spec_helper"

describe StudentsController do
  let(:student) { FactoryGirl.create(:student) }
  before(:each) { login_user student }

  describe "POST #add_course" do
    let(:course) { FactoryGirl.create(:course) }

    context "with existant course" do
      it "adds the course to the student" do
        expect {
          post :add_course, id: student, course: course.attributes
        }.to change(student.courses, :count).by 1
      end

      it "redirects to the root path" do
        post :add_course, id: student, course: course.attributes
        expect(response).to redirect_to root_path
      end

      context "and course already added" do
        before { student.courses << course }

        it "does not add the course to the student" do
          expect {
            post :add_course, id: student, course: course.attributes
          }.to change(student.courses, :count).by 0
        end

        it "flashes an error message" do
          post :add_course, id: student, course: course.attributes
          expect(flash[:alert]).to match /already added/m
        end
      end
    end

    context "with nonexistant course" do
      it "does not add the course to the student" do
        expect {
          post :add_course, id: student, course: {}
        }.to change(student.courses, :count).by 0
      end

      it "flashes an error message" do
        post :add_course, id: student, course: {}
        expect(flash[:alert]).to match /No courses were found/m
      end
    end
  end

  describe "DELETE #leave_course" do
    let(:course) { FactoryGirl.create(:course) }
    before(:each) { student.courses << course }

    context "with existant course" do
      it "removes the course from the student" do
        expect {
          delete :leave_course, id: student, course: course.attributes
        }.to change(student.courses, :count).by -1
      end

      it "redirects to the root path" do
        delete :leave_course, id: student, course: course.attributes
        expect(response).to redirect_to root_path
      end
    end

    context "with nonexistant course" do
      it "flashes an error message" do
        post :leave_course, id: student, course: {}
        expect(flash[:alert]).to match /error occured/m
      end
    end
  end
end
