require 'spec_helper'

describe "Teacher" do
	let(:teacher) {FactoryGirl.create(:teacher)}
	
	subject {teacher}

	it { should respond_to(:school) }
	it { should respond_to(:state) }
	it { should respond_to(:country) }
	
	it "should have an user" do
		teacher.user.should be_an(User)
	end

	describe "when first name is not present" do
		before {teacher.user.first_name = ""}
		it {should_not be_valid}
	end

	describe "when last name is not present" do
		before {teacher.user.last_name = ""}
		it {should_not be_valid}
	end

	describe "when email is not present" do
		before {teacher.user.email = ""}
		it {should_not be_valid}
	end

	describe "when password is not present" do
		before {teacher.user.password = ""}
		it {should_not be_valid}
	end
	
	describe "when confirmation is not present" do
		before {teacher.user.password_confirmation = ""}
		it {should_not be_valid}
	end

	describe "when the email address has the correct format" do
		it "should be valid" do
			addresses = %w[user@domain.com fake.user@domain.org fake+user@domain.co.uk]
			addresses.each do |a|
				teacher.user.email = a
				teacher.should be_valid
			end
		end
	end

	describe "when the email address has the incorrect format" do
		it "should not be valid" do
			addresses = %w[user@domain,com user_at_domain_dot_org user@udomain. @domain.com]
			addresses.each do |a|
				teacher.user.email = a
				teacher.should_not be_valid
			end
		end
	end

	describe "deleting Teachers" do
	   it "should destroy the user when teacher is destroyed" do
     		@user = teacher.user
     		teacher.destroy
       		User.find_by_id(@user.id).should eq nil
     	end
   end   	
end