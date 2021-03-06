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
    it { is_expected.to have_content unit.number }
    it { is_expected.to have_content unit.name }
    it { is_expected.to have_title unit.name }

    describe "concept attributes" do
      let(:concept) { unit.concepts.first }

      it { is_expected.to have_content concept.name }
      it { is_expected.to have_content concept.description }
      it { is_expected.to have_content concept.dok1_resources }
      it { is_expected.to have_content concept.dok2_resources }
      it { is_expected.to have_content concept.dok3_resources }

      describe "when concept isn't in current unit" do
        let(:concept) { FactoryGirl.create(:concept) }
        before do
          user.courses << concept.unit.course
          visit current_path
        end

        it { is_expected.not_to have_content concept.name }
        it { is_expected.not_to have_content concept.description }
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
          fill_in "Recall & Reproduction", with: concept[:dok1_resources]
          fill_in "Routine Problems", with: concept[:dok2_resources]
          fill_in "Non-Routine Problems", with: concept[:dok3_resources]
          click_button "Update Concept"
        end

        context "with valid attributes" do
          let(:concept) { FactoryGirl.attributes_for(:concept) }
          it { is_expected.to have_content concept[:name] }
          it { is_expected.to have_content concept[:description] }
          it { is_expected.to have_content concept[:dok1_resources]}
          it { is_expected.to have_content concept[:dok2_resources]}
          it { is_expected.to have_content concept[:dok3_resources]}
        end

        context "with invalid attributes" do
          let(:concept) { FactoryGirl.attributes_for(:invalid_concept) }
          it { is_expected.to have_content "can't be blank" }
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
