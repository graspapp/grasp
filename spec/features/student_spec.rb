require 'spec_helper'

describe "Student" do
	let(:student) {FactoryGirl.create(:student)}
	
	subject {student}

	
	it "should have an user" do
		student.user.should be_an(User)
	end

	describe "when first name is not present" do
		before {student.user.first_name = ""}
		it {should_not be_valid}
	end

	describe "when last name is not present" do
		before {student.user.last_name = ""}
		it {should_not be_valid}
	end

	describe "when email is not present" do
		before {student.user.email = ""}
		it {should_not be_valid}
	end

	describe "when password is not present" do
		before {student.user.password = ""}
		it {should_not be_valid}
	end
	
	describe "when confirmation is not present" do
		before {student.user.password_confirmation = ""}
		it {should_not be_valid}
	end

	describe "when the email address has the correct format" do
		it "should be valid" do
			addresses = %w[user@domain.com fake.user@domain.org fake+user@domain.co.uk]
			addresses.each do |a|
				student.user.email = a
				student.should be_valid
			end
		end
	end

	describe "when the email address has the incorrect format" do
		it "should not be valid" do
			addresses = %w[user@domain,com user_at_domain_dot_org user@udomain. @domain.com]
			addresses.each do |a|
				student.user.email = a
				student.should_not be_valid
			end
		end
	end

	describe "deleting Students" do
	   it "should destroy the user when student is destroyed" do
     		@user = student.user
     		student.destroy
       		User.find_by_id(@user.id).should eq nil
     	end
   end   	
end