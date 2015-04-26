require "spec_helper"

describe ApplicationController do
  describe "custom user methods" do
    describe "when logged in as a student" do
      let(:student) { FactoryGirl.create(:student) }
      before { sign_in student }

      it { expect(controller.current_student).to eq student }
      it { expect(controller.current_teacher).to eq nil }
      
      it { expect(controller.student_signed_in?).to be true }
      it { expect(controller.teacher_signed_in?).to be false }
    end

    describe "when logged in as a teacher" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      before { sign_in teacher }

      it { expect(controller.current_teacher).to eq teacher }
      it { expect(controller.current_student).to eq nil }

      it { expect(controller.teacher_signed_in?).to be true }
      it { expect(controller.student_signed_in?).to be false }
    end
  end
end
