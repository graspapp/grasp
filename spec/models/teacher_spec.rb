require 'spec_helper'

describe "Teacher" do
  
  let(:teacher) { FactoryGirl.create(:teacher) }
  
  subject { teacher }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:school) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:country) }

  describe "when first name is blank" do
    before { teacher.first_name = "" }
    it { should_not be_valid}
  end

  describe "when last name is blank" do
    before { teacher.last_name = "" }
    it { should_not be_valid }
  end
  
  describe "when email is blank" do
    before { teacher.email = "" }
    it { should_not be_valid }
  end

  describe "when password is blank" do
    before { teacher.password = "" }
    it { should_not be_valid }
  end

  describe "when password confirmation is blank" do
    before { teacher.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when school is blank" do
    before { teacher.school = "" }
    it { should_not be_valid }
  end

    describe "when city is blank" do
    before { teacher.city = "" }
    it { should_not be_valid }
  end

    describe "when state is blank" do
    before { teacher.state = "" }
    it { should_not be_valid }
  end

    describe "when country confirmation is blank" do
    before { teacher.country = "" }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before { teacher.password = teacher.password_confirmation = "short" }
    it { should_not be_valid }
  end
  
  describe "email address validation" do
    it "should be valid" do
      addresses = %w[teacher@teacher.com dummy.teacher@teacher.org
                     dummy_teacher@teacher.org dummy+teacher@teacher.co.uk]
      addresses.each do |a|
        teacher.email = a
        teacher.should be_valid
      end
    end
    
    it "should be invalid" do
      addresses = %w[teacher@teacher,com teacher_at_teacher_dot_org
                     teacher@teacher.]
      addresses.each do |a|
        teacher.email = a
        teacher.should_not be_valid
      end
    end
  end 
  
  describe "when email address is in use" do

  let(:teacher2) do
    FactoryGirl.build(:teacher, email: teacher.email)
  end
  
  subject { teacher2 }
  
  before do
    teacher2.save
  end

  it { should_not be_valid }
 end
end