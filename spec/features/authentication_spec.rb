require "spec_helper"

describe "Authentication" do
  subject { page }

  describe "user registration" do

    describe "students" do 
      before { visit student_sign_up_path }

      context "with invalid information" do
        before { click_button "Sign up" }

        it { should have_title("Sign up") }
        it { should have_content("can't be blank") }
      end

      context "with valid information" do
        before do
          # Preferably we'd just get the student's attributes, but FactoryGirl
          # doesn't like nested attributes.
          #
          # See https://github.com/thoughtbot/factory_girl/issues/359
          @user = FactoryGirl.attributes_for(:user)

          fill_in "First name", with: @user[:first_name]
          fill_in "Last name", with: @user[:last_name]
          fill_in "Email", with: @user[:email]
          fill_in "Password", with: @user[:password], match: :prefer_exact
          fill_in "Password confirmation", with: @user[:password_confirmation],
            match: :prefer_exact
          click_button "Sign up"
        end

        it { should have_link("Sign out", href: destroy_user_session_path) }
        it { should_not have_link("Sign in") }
        it { should have_title("#{@user[:first_name]} #{@user[:last_name]}") }

        describe "followed by sign out" do
          before { first(:link, "Sign out").click }
          it { should have_link("Sign up") }
        end
      end
    end

    context "teachers" do
      before do

      end
    end
  end

  describe "user login" do
    before { visit new_user_session_path }

    describe "students" do
      
      context "with invalid information" do
        before { click_button "Sign in" }

        it { should have_title("Sign in") }
        it { should have_content("Invalid") }
      end

      context "with valid information" do
        before do
          @student = FactoryGirl.create(:student)

          fill_in "Email", with: @student.user.email
          fill_in "Password", with: @student.user.password
          click_button "Sign in"
        end

        it { should have_title(full_name(@student.user)) }
        it { should have_link("Sign out") }
        it { should_not have_link("Sign in") }
      end
    end
  end
end
