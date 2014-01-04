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

    describe "GET #show" do
      before { get :show, id: unit }

      it "assigns the requested concept to @concept" do
        expect(assigns(:concept)).to eq concept
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end
  end
end
