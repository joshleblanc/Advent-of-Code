class Equipment

  attr_reader :cost, :damage, :armor
  def initialize(name, cost, damage, armor)
    @name = name
    @cost = cost.to_i
    @damage = damage.to_i
    @armor = armor.to_i
  end

  def self.from_text(line)
    new(*line.strip.sub(' +', '+').split)
  end

  def to_s
    "#{@name}: #{@cost} #{@damage} #{@armor}"
  end

end
