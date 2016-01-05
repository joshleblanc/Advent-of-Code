require_relative 'entity.rb'

class Hero < Entity

  def initialize
    weapon = Equipment.new("Hands", 0, 0, 0)
    armor = Equipment.new("Naked", 0, 0, 0)
    super(100, weapon, armor)
  end

  def set_equipment!(loadout)
    @weapon = loadout[:weapon]
    @armor = loadout[:armor]
    @rings = loadout[:rings]
  end
end
