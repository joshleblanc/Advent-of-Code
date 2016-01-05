require_relative 'entity.rb'

class Boss < Entity

  def initialize(file)
    attributes = File.read(file).lines.map { |s| s.split.last }
    weapon = Equipment.new("BossWeapon", 0, attributes[1], 0)
    armor = Equipment.new("BossArmor", 0, 0, attributes[2])
    super(attributes[0], weapon, armor)
  end
end
