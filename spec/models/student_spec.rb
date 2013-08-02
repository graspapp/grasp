require 'spec_helper'

describe "Student" do
  
  let(:student) { FactoryGirl.create(:student) }

  subject { student }

  it { should have_many(:courses).through(:enrollments) }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:class_code) }

  describe "when first name is blank" do

    before { student.first_name = "" }

    it { should_not be_valid}
  end

  describe "when last name is blank" do

    before { student.last_name = "" }

    it { should_not be_valid}
  end
  
  describe "when email is blank" do

    before { student.email = "" }

    it { should_not be_valid }
  end

  describe "when password is blank" do

    before { student.password = "" }

    it { should_not be_valid }
  end

  describe "when password confirmation is blank" do

    before { student.password_confirmation = "" }

    it { should_not be_valid }
  end

  describe "when class code is blank" do

    before { student.class_code = "" }

    it { should_not be_valid }
  end

  describe "when password is too short" do

    before { student.password = student.password_confirmation = "short" }

    it { should_not be_valid }
  end
    
  describe "email address validation" do

    it "should be valid" do

      addresses = %w[student@student.com dummy.student@student.org
                     dummy_student@student.org dummy+student@student.co.uk]

      addresses.each do |a|
        student.email = a
        student.should be_valid
      end
    end
    
    it "should be invalid" do

      addresses = %w[student@student,com student_at_student_dot_org
                     student@student.]

      addresses.each do |a|
        student.email = a
        student.should_not be_valid
      end
    end
  end 
  
  describe "when email address is in use" do
    let(:student2) do
      FactoryGirl.build(:student, email: student.email)
    end
  
    subject { student2 }
  
    before do
      student2.save
    end

    it { should_not be_valid }
 end
end
