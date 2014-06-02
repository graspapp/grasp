require "spec_helper"

describe "Unit show" do
  let(:unit) { FactoryGirl.create(:unit_with_concepts, concepts_count: 1) }
  before(:each) do
    user.courses << unit.course

    login_as(user, scope: :user)
    visit unit_path(unit)
  end

  subject { page }

  shared_examples_for "a unit show page" do
    it { should have_content unit.number }
    it { should have_content unit.name }
    it { should have_title unit.name }

    describe "concept attributes" do
      let(:concept) { unit.concepts.first }

      it { should have_content concept.name }
      it { should have_content concept.description }

      describe "when concept isn't in current unit" do
        let(:concept) { FactoryGirl.create(:concept) }
        before do
          user.courses << concept.unit.course
          visit current_path
        end

        it { should_not have_content concept.name }
        it { should_not have_content concept.description }
      end
    end
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }
    it_should_behave_like "a unit show page"
    
    describe "multiple concepts" do
      let(:concept) { unit.concepts.first }
      let(:concept2) { FactoryGirl.create(:concept) }
      before do
        unit.concepts << concept2
      end
      
      it "should be displayed in the correct order" do
        expect(unit.concepts.to_a).to eq [concept, concept2]
      end
      
    end
    
    describe "actions" do
      describe "editing concept" do
        before do
          first(:link, "Edit").click

          fill_in "Name", with: concept[:name]
          fill_in "Description", with: concept[:description]
          click_button "Update Concept"
        end

        context "with valid attributes" do
          let(:concept) { FactoryGirl.attributes_for(:concept) }
          it { should have_content concept[:name] }
          it { should have_content concept[:description] }
        end

        context "with invalid attributes" do
          let(:concept) { FactoryGirl.attributes_for(:invalid_concept) }
          it { should have_content "can't be blank" }
        end
      end
      
      example "deleting concept" do
        expect {
          first(:link, "Delete").click
          unit.reload
        }.to change(unit.concepts, :count).by -1
      end
    end
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }
    it_should_behave_like "a unit show page"
  end
end
