module UnitsHelper
  def unit_name(unit)
    "Unit #{ unit.number }: #{ unit.name }"
  end

  def show_concept_actions?(unit)
    unit.concepts.map { |c|
      policy(c).edit? or policy(c).destroy?
    }.any?
  end
end
