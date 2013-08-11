require 'spec_helper'

describe 'Authentication' do

  let(:teacher) { FactoryGirl.create(:teacher) }
  let(:student) { FactoryGirl.create(:student) }

  subject { page }

  describe 'teacher registration page' do

    before { visit teacher_sign_up_path }

    it { should have_selector('h1', text: 'Sign Up') }
  end

  describe 'teacher registration' do

    before { visit teacher_sign_up_path }

    describe 'with invalid information' do

      it 'should not create a new teacher' do
        expect { click_button 'Create Account' }.not_to change(Teacher, :count)
      end

      describe 'submission results' do

        before { click_button 'Create Account' }
        it { should have_selector('h1', text: 'Sign Up') }
        it { should have_content('error') }
        it { should have_field('School') } # test for teacher specific field
      end
    end

    describe 'with valid information' do

      let(:teacher2) do
        FactoryGirl.build(:teacher, email: 'teacher2@email.com')
      end

      it 'should allow new teacher to sign up' do
        fill_in 'First name',            with: teacher2.first_name
        fill_in 'Last name',             with: teacher2.last_name
        fill_in 'Email',                 with: teacher2.email
        fill_in 'Password',              with: teacher2.password
        fill_in 'Password confirmation', with: teacher2.password_confirmation
        fill_in 'School',                with: teacher2.school
        fill_in 'City',                  with: teacher2.city
        fill_in 'State',                 with: teacher2.state
        fill_in 'Country',               with: teacher2.country

        expect do
          click_button 'Create Account'
        end.to change(Teacher, :count).by(1)
      end
    end
  end

  describe 'student registration page' do

    before { visit student_sign_up_path }

    it { should have_selector('h1', text: 'Sign Up') }
  end

  describe 'student registration' do

    before { visit student_sign_up_path }

    describe 'with invalid information' do

      it 'should not create a new student' do
        expect { click_button 'Create Account' }.not_to change(Student, :count)
      end

      describe 'submission results' do

        before { click_button 'Create Account' }
        it { should have_selector('h1', text: 'Sign Up') }
        it { should have_content('error') }
        it { should have_field('Class code') }
      end
    end

    describe 'with valid information' do

      let(:student2) do
        FactoryGirl.build(:student, email: 'student2@email.com')
      end

      it 'should allow a new student to sign up' do
        fill_in 'First name',            with: student2.first_name
        fill_in 'Last name',             with: student2.last_name
        fill_in 'Email',                 with: student2.email
        fill_in 'Password',              with: student2.password
        fill_in 'Password confirmation', with: student2.password_confirmation
        fill_in 'Class code',            with: student2.class_code

        expect do
          click_button 'Create Account'
        end.to change(Student, :count).by(1)
      end
    end
  end

  describe 'sign in page' do

    before { visit sign_in_path }

    it { should have_selector('h1', text: 'Sign in') }
  end

  describe 'signing in' do

    before { visit sign_in_path }

    describe 'with invalid credentials' do

      before { click_button 'Sign in' }

      it do
        should have_selector('p.alert.alert-error',
                             text: 'Invalid email or password.')
      end
    end

    describe 'with teacher credentials' do

      before { sign_in(teacher) }

      it do
        should have_selector('h1', text: teacher.full_name)
      end

      it do
        should have_selector('p.alert.alert-success',
                             text: 'Signed in successfully.')
      end
    end

    describe 'with student credentials' do

      before { sign_in(student) }

      it do
        should have_selector('h1', text: student.full_name)
      end

      it do
        should have_selector('p.alert.alert-success',
                             text: 'Signed in successfully.')
      end
    end
  end
end
