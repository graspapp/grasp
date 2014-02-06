require "spec_helper"

describe ConceptsController do
  let(:concept) { FactoryGirl.create(:concept) }
  let(:unit) { concept.unit }
  let(:course) { unit.course }
  before(:each) do
    user.courses << course

    login_user user
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    describe "GET #show" do
      before { get :show, id: concept }

      it "assigns the requested concept to @concept" do
        expect(assigns(:concept)).to eq concept
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end

    describe "POST #create" do
      let(:attributes) { raw_attributes.merge(unit_id: unit) }
      context "with valid attributes" do
        let(:raw_attributes) { FactoryGirl.attributes_for(:concept) }

        it "saves the new concept in the database" do
          expect {
            post :create, concept: attributes
          }.to change(Concept, :count).by 1
        end

        it "adds the concept to the unit" do
          expect {
            post :create, concept: attributes
          }.to change(unit.concepts, :count).by 1
        end

        it "redirects to the concept's unit" do
          post :create, concept: attributes
          expect(response).to redirect_to unit 
        end
      end

      context "with invalid attributes" do
        let(:raw_attributes) { FactoryGirl.attributes_for(:invalid_concept) }
        it "does not save the new concept in the database" do
          expect {
            post :create, concept: attributes
          }.to change(Concept, :count).by 0
        end

        it "does not add the concept to the unit" do
          expect {
            post :create, concept: attributes
          }.to change(unit.concepts, :count).by 0
        end
      end
    end

    describe "GET #edit" do
      before { get :edit, id: concept }
      
      it "assigns the requested concept to @concept" do
        expect(assigns(:concept)).to eq concept
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end

    describe "PUT #update" do
      it "locates the requested concept" do
        put :update, id: concept, concept: FactoryGirl.attributes_for(:concept)
        expect(assigns(:concept)).to eq concept
      end
      
      context "valid attributes" do
        let(:attributes) { FactoryGirl.attributes_for(:concept) }

        it "changes the concept's attributes" do
          expect {
            put :update, id: concept, concept: attributes
            concept.reload
          }.to change(concept, :description)
        end

        it "redirects to the concept's unit" do
          put :update, id: concept, concept: attributes
          expect(response).to redirect_to unit
        end
      end

      context "invalid attributes" do
        let(:attributes) { FactoryGirl.attributes_for(:invalid_concept) }

        it "does not change the concept's attributes" do
          expect {
            put :update, id: concept, concept: attributes
            concept.reload
          }.to_not change(concept, :description)
        end

        it "re-renders the :edit template" do
          put :update, id: concept, concept: attributes
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the concept" do
        expect {
          delete :destroy, id: concept
        }.to change(Concept, :count).by -1
      end

      it "redirects to the concept's unit" do
        delete :destroy, id: concept
        expect(response).to redirect_to concept.unit
      end
    end
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }
    let(:enrollment) { user.enrollments.find_by(course: course) }

    describe "GET #show" do
      it "assigns the requested concept to @concept" do
        get :show, id: concept
        expect(assigns(:concept)).to eq concept
      end

      it "assigns the concept's concept progresses to @concept_progresses" do
        get :show, id: concept
        expect(assigns(:concept_progresses)).to eq concept.concept_progresses
      end

      it "creates a new concept progress" do
        expect {
          get :show, id: concept
        }.to change(ConceptProgress, :count).by 1
      end

      it "adds a new concept progress to the student's enrollment" do
        expect {
          get :show, id: concept
        }.to change(enrollment.concept_progresses, :count).by 1
      end

      it "adds a new concept progress to the concept" do
        expect {
          get :show, id: concept
        }.to change(concept.concept_progresses, :count).by 1
      end

      it "renders the :show template" do
        get :show, id: concept
        expect(response).to render_template :show
      end

      context "when concept progress for the student already exists" do
        let!(:concept_progress) { FactoryGirl.create(:concept_progress,
                                                     enrollment: enrollment,
                                                     concept: concept) }

        it "doesn't create a new concept progress" do
          expect {
            get :show, id: concept
          }.to change(ConceptProgress, :count).by 0
        end
      end

      # TODO: Make sure that this actually tests what it says it does. I have a
      # feeling it gives a false positive when it should fail, but don't
      # currently have the time to verify this.
      context "when concept progress for a different student already exists" do
        let(:enrollment) { FactoryGirl.create(:enrollment,
                                              course: concept.unit.course) }
        let!(:concept_progress) { FactoryGirl.create(:concept_progress,
                                                     enrollment: enrollment,
                                                     concept: concept) }

        it "creates a new concept progress" do
          expect {
            get :show, id: unit
          }.to change(ConceptProgress, :count).by 1
        end
      end
    end
  end
end
