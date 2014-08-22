require "spec_helper"

describe ConceptProgressesController do
  let(:concept_progress) { FactoryGirl.create(:concept_progress) }
  let(:enrollment) { concept_progress.enrollment }
  let(:concept) { concept_progress.concept }
  let(:unit) { concept.unit }
  let(:course) { unit.course }
  before(:each) do
    user.courses << course

    login_user user
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    describe "GET #edit" do
      before { get :edit, id: concept_progress }

      it "assigns the requested concept progress to @concept_progress" do
        expect(assigns(:concept_progress)).to eq concept_progress 
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end
    
    describe "GET #show" do
      before { get :show, id: concept_progress }
      
      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end

    describe "PUT #update" do
      it "locates the requested concept progress" do
        put :update, id: concept_progress,
          concept_progress: FactoryGirl.attributes_for(:concept_progress)
        expect(assigns(:concept_progress)).to eq concept_progress
      end

      context "valid attributes" do
        let(:concept_progress) do
          FactoryGirl.create(:concept_progress, type_of_error: "Procedural")
        end
        let(:attributes) do
          FactoryGirl.attributes_for(:concept_progress,
                                     type_of_error: "Conceptual")
        end

        it "changes the concept progress's attributes" do
          expect {
            put :update, id: concept_progress, concept_progress: attributes
            concept_progress.reload
          }.to change(concept_progress, :type_of_error)
        end

        it "redirects to the concept progresses's concept" do
          put :update, id: concept_progress, concept_progress: attributes
          expect(response).to redirect_to concept_progress.concept
        end
      end

      context "invalid attributes" do
        let(:attributes) do
          FactoryGirl.attributes_for(:invalid_concept_progress)
        end

        it "does not change the concept progresses's attributes" do
          expect {
            put :update, id: concept_progress, concept_progress: attributes
            concept_progress.reload
          }.to_not change(concept_progress, :next_steps)
        end

        it "re-renders the :edit template" do
          put :update, id: concept_progress, concept_progress: attributes
          expect(response).to render_template :edit
        end
      end
    end
  end
end
