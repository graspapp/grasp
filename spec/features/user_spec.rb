require 'spec_helper'

describe "User" do
	before do
		@user = User.new(first_name: "Sample", last_name: "Teacher", email: "sampleteach@school.edu", password: "fakepass", password_confirmation: "fakepass")
	end

	subject { @user }

	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	describe "when first name is blank" do
		before {@user.first_name = ""}
		it { should_not be_valid}
	end

	describe "when last name is blank" do
		before {@user.last_name = ""}
		it { should_not be_valid}
	end
	
	describe "when email is blank" do
		before {@user.email = ""}
		it { should_not be_valid}
	end

	describe "when password is blank" do
		before {@user.password = ""}
		it { should_not be_valid}
	end

	describe "when password_confirmation is blank" do
		before {@user.password_confirmation = ""}
		it { should_not be_valid}
	end

  describe "when password is too short" do
    before { @user.password = @user.password_confirmation = "short" }
    it { should_not be_valid }
  end
    
  
  describe "email address validation" do
    it "should be valid" do
      addresses = %w[user@user.com dummy.user@user.org dummy_user@user.org dummy+user@user.co.uk]
      addresses.each do |a|
        @user.email = a
        @user.should be_valid
      end
    end
    
    it "should be invalid" do
      addresses = %w[user@user,com user_at_user_dot_org user@user.]
      addresses.each do |a|
        @user.email = a
        @user.should_not be_valid
      end
    end
  end 
  
  describe "when email address is in use" do
    before do
      new_user = @user.dup
      new_user.save
  end
  it { should_not be_valid }
 end
end
