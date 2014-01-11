require "spec_helper"

describe UnitsHelper do
  describe "unit name" do
    let(:unit) { FactoryGirl.create(:unit) }

    example do
      expect(unit_name unit).to eq "Unit #{ unit.number}: #{ unit.name }"
    end
  end
end
