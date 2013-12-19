require "spec_helper"

describe ApplicationController do
  describe "custom user methods" do
    describe "when logged in as a student" do
      before do
        @student = FactoryGirl.create(:student)
        sign_in @student.user
      end

      it { controller.current_student.should eq @student }
      it { controller.current_teacher.should eq nil }
      
      it { controller.student_signed_in?.should be true }
      it { controller.teacher_signed_in?.should be false }
    end

    describe "when logged in as a teacher" do
      before do
        @teacher = FactoryGirl.create(:teacher)
        sign_in @teacher.user
      end

      it { controller.current_teacher.should eq @teacher }
      it { controller.current_student.should eq nil }

      it { controller.teacher_signed_in?.should be true }
      it { controller.student_signed_in?.should be false }
    end
  end
end
