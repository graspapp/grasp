require "spec_helper"

describe ApplicationController do
  describe "custom user methods" do
    describe "when logged in as a student" do
      let(:student) { FactoryGirl.create(:student) }
      before { sign_in student }

      it { controller.current_student.should eq student }
      it { controller.current_teacher.should eq nil }
      
      it { controller.student_signed_in?.should be true }
      it { controller.teacher_signed_in?.should be false }
    end

    describe "when logged in as a teacher" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      before { sign_in teacher }

      it { controller.current_teacher.should eq teacher }
      it { controller.current_student.should eq nil }

      it { controller.teacher_signed_in?.should be true }
      it { controller.student_signed_in?.should be false }
    end
  end
end
