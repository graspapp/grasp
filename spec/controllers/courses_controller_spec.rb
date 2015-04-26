require "spec_helper"

describe CoursesController do
  subject { response }

  context "when logged in as a teacher" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before(:each) { login_user teacher }

    describe "GET #show" do
      let(:course) { FactoryGirl.create(:course) }

      context "when teacher owns course" do
        before do
          teacher.courses << course

          get :show, id: course
        end

        it "assigns the requested course to @course" do
          expect(assigns(:course)).to eq course
        end

        it "assign's the course's units to @units" do
          expect(assigns(:units)).to be_instance_of course.units.class
        end

        it "assigns a new unit to @unit" do
          expect(assigns(:unit)).to be_instance_of Unit
        end

        it "renders the :show template" do
          expect(response).to render_template :show
        end
      end

      context "when teacher doesn't own course" do
        before { get :show, id: course }
        it_should_behave_like "a forbidden action"
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new course in the database" do
          expect {
            post :create, course: FactoryGirl.attributes_for(:course)
          }.to change(Course, :count).by 1
        end

        it "adds the course to the teacher" do
          expect {
            post :create, course: FactoryGirl.attributes_for(:course)
          }.to change(teacher.courses, :count).by 1
        end

        it "redirects to the homepage" do
          post :create, course: FactoryGirl.attributes_for(:course)
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid attributes" do
        it "does not save the new course in the database" do
          expect {
            post :create, course: FactoryGirl.attributes_for(:invalid_course)
          }.to change(Course, :count).by 0
        end

        it "does not add the course to the teacher" do
          expect {
            post :create, course: FactoryGirl.attributes_for(:invalid_course)
          }.to change(teacher.courses, :count).by 0
        end
      end
    end

    describe "PUT #update" do
      let(:course) { FactoryGirl.create(:course) }

      context "when teacher owns course" do
        before { teacher.courses << course }

        context "valid attributes" do
          it "locates the requested course" do
            put :update, id: course,
              course: FactoryGirl.attributes_for(:course)
            expect(assigns(:course)).to eq course
          end

          it "changes course's attributes" do
            expect {
              put :update, id: course,
                course: FactoryGirl.attributes_for(:course)
              course.reload
            }.to change(course, :name)
          end

          it "redirects to the root path" do
            put :update, id: course,
              course: FactoryGirl.attributes_for(:course)
            expect(response).to redirect_to root_path
          end
        end

        context "invalid attributes" do
          it "locates the requested @course" do
            put :update, id: course,
              course: FactoryGirl.attributes_for(:invalid_course)
            expect(assigns(:course)).to eq course
          end

          it "does not change @course's attributes" do
            expect {
              put :update, id: course,
              course: FactoryGirl.attributes_for(:invalid_course)
              course.reload
            }.to_not change(course, :name)
          end

          it "re-renders the edit template" do
            put :update, id: course,
              course: FactoryGirl.attributes_for(:invalid_course)
            expect(response).to render_template :edit
          end
        end
      end

      context "when teacher doesn't own course" do
        it "doesn't change course's attributes" do
          expect {
            put :update, id: course,
              course: FactoryGirl.attributes_for(:course)
          }.to_not change(course, :name)
        end

        before { put :update, id: course,
                 course: FactoryGirl.attributes_for(:course) }
        it_should_behave_like "a forbidden action"
      end
    end

    describe "DELETE #destroy" do
      let(:course) { FactoryGirl.create(:course) }

      context "when teacher owns course" do
        before { teacher.courses << course }

        it "deletes the Course" do
          expect {
            delete :destroy, id: course
          }.to change(Course, :count).by -1
        end

        it "redirects to homepage" do
          delete :destroy, id: course
          expect(response).to redirect_to root_path
        end
      end

      context "when teacher doesn't own course" do
        it "does not delete the Course" do
          expect {
            delete :destroy, id: course
          }.to change(Course, :count).by 0
        end

        before { delete :destroy, id: course }
        it_should_behave_like "a forbidden action"
      end
    end
  end

  context "when logged in as a student" do
    render_views

    let(:student) { FactoryGirl.create(:student) }
    before(:each) { login_user student }

    describe "GET #show" do
      let(:course) { FactoryGirl.create(:course) }

      context "when student is in course" do
        before do
          student.courses << course

          get :show, id: course
        end

        it "assigns the requested course to @course" do
          expect(assigns(:course)).to eq course
        end

        it "renders the :show template" do
          expect(response).to render_template :show
        end
      end

      context "when student is not in course" do
        before { get :show, id: course }

        it_should_behave_like "a forbidden action"
      end
    end

    describe "POST #create" do
      before { post :create, course: FactoryGirl.attributes_for(:course) }
      it_should_behave_like "a forbidden action"
    end

    describe "PUT #update" do
      before do
        put :update, id: FactoryGirl.create(:course),
          course: FactoryGirl.attributes_for(:course)
      end
      it_should_behave_like "a forbidden action"
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: FactoryGirl.create(:course).id }
      it_should_behave_like "a forbidden action"
    end
  end
end
