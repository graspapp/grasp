require 'spec_helper'

describe UnitsController do
  let(:unit) { FactoryGirl.create(:unit) }

  context "as a teacher" do
    let(:teacher) { FactoryGirl.create(:teacher_with_courses,
                                       courses_count: 1) }
    let(:course) { teacher.courses.first }
    before(:each) do
      course.units << unit

      login_user teacher
    end

    describe "GET #show" do
      before { get :show, id: unit }

      it "assigns the requested unit to @unit" do
        expect(assigns(:unit)).to eq unit
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end

    describe "POST #create" do
      let(:attributes) { raw_attributes.merge(course_id: course) }

      context "with valid attributes" do
        let(:raw_attributes) { FactoryGirl.attributes_for(:unit) }

        it "saves the new unit in the database" do
          expect {
            post :create, unit: attributes
          }.to change(Unit, :count).by 1
        end

        it "adds the unit to the course" do
          expect {
            post :create, unit: attributes
          }.to change(course.units, :count).by 1
        end

        it "redirects to the unit's course" do
          post :create, unit: attributes
          expect(response).to redirect_to course
        end
      end

      context "with invalid attributes" do
        let(:raw_attributes) { FactoryGirl.attributes_for(:invalid_unit) }
        it "does not save the new unit in the database" do
          expect {
            post :create, unit: attributes
          }.to change(Unit, :count).by 0
        end

        it "does not add the unit to the course" do
          expect {
            post :create, unit: attributes
          }.to change(course.units, :count).by 0
        end
      end
    end

    describe "GET #edit" do
      before { get :edit, id: unit }

      it "assigns the requested unit to @unit" do
        expect(assigns(:unit)).to eq unit
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end

    describe "PUT #update" do
      it "locates the requested unit" do
        put :update, id: unit, unit: FactoryGirl.attributes_for(:unit)
        expect(assigns(:unit)).to eq unit
      end

      context "valid attributes" do
        it "changes the unit's attributes" do
          expect {
            put :update, id: unit, unit: FactoryGirl.attributes_for(:unit)
            unit.reload
          }.to change(unit, :name)
        end

        it "redirects to the unit's course" do
          put :update, id: unit, unit: FactoryGirl.attributes_for(:unit)
          expect(response).to redirect_to course
        end
      end

      context "invalid attributes" do
        it "does not change the unit's attributes" do
          expect {
            put :update, id: unit,
              unit: FactoryGirl.attributes_for(:invalid_unit)
            unit.reload
          }.to_not change(unit, :name)
        end

        it "re-renders the :edit template" do
          put :update, id: unit,
            unit: FactoryGirl.attributes_for(:invalid_unit)
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the unit" do
        expect { 
          delete :destroy, id: unit
        }.to change(Unit, :count).by -1
      end

      it "redirects to the unit's course" do
        delete :destroy, id: unit
        expect(response).to redirect_to course
      end
    end
  end

  context "as a student" do
    let(:student) { FactoryGirl.create(:student_with_courses,
                                       courses_count: 1) }
    let(:course) { student.courses.first }
    before(:each) do
      course.units << unit

      login_user student
    end

    describe "GET #show" do
      before { get :show, id: unit }

      it "assigns the requested unit to @unit" do
        expect(assigns(:unit)).to eq unit
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end
end
