require_relative 'equipment.rb'
require 'pp'

class Shop

  def initialize(file)
    items = File.read(file).lines.chunk { |i| i.include?(":") }.reject(&:first).map(&:last)
    @weapons = stock(items[0])

    @armor = stock(items[1])
    @armor << Equipment.new("Naked", 0, 0, 0)

    @rings = stock(items[2])
    @rings << Equipment.new("Empty (L)", 0, 0, 0)
    @rings << Equipment.new("Empty (R)", 0, 0 ,0)
  end

  def print_inventory
    puts "Weapons"
    puts @weapons
    puts "\nArmor"
    puts @armor
    puts "\nRings"
    puts @rings
  end

  def each_combination
    @weapons.each do |weapon|
      @armor.each do |armor|
        @rings.combination(2).each do |rings|
          yield({
            cost: weapon.cost + armor.cost + rings.inject(0) { |s, r| s + r.cost},
            equipment: {
              weapon: weapon,
              armor: armor,
              rings: rings
            }
          })
        end
      end
    end
  end

  private
  def stock(items)
    items.map do |item|
      Equipment.from_text(item) if item.strip.length > 0
    end.compact
  end

end
