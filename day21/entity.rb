class Entity

  attr_accessor :weapon, :armor, :rings, :hp

  def initialize(hp, weapon, armor, rings=[])
    @hp = hp.to_i
    @max_hp = hp.to_i
    @weapon = weapon
    @armor = armor
    @rings = rings
  end

  def heal!
    @hp = @max_hp
  end

  def attack!(target)
    target.hp -= total_damage - target.total_armor
  end

  def total_damage
    @weapon.damage + @rings.inject(0) { |sum, ring| sum + ring.damage }
  end

  def total_armor
    @armor.armor + @rings.inject(0) { |sum, ring| sum + ring.armor }
  end

  def dead?
    @hp <= 0
  end

  def to_s
    @hp
  end

end
