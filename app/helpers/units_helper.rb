module UnitsHelper
  def formatted_name(unit)
    "Unit #{ unit.number }: #{ unit.name }"
  end
end
