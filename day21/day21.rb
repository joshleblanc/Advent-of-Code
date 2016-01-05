require_relative 'shop.rb'
require_relative 'hero.rb'
require_relative 'boss.rb'
require_relative 'game.rb'

shop = Shop.new('inventory')
boss = Boss.new('input')
hero = Hero.new
costs_when_winner = []
costs_when_loser = []

game = Game.new(hero, boss)
shop.each_combination do |loadout|
  game.reset!
  game.hero.set_equipment!(loadout[:equipment])
  if game.sim! == game.hero
    costs_when_winner << loadout[:cost]
  else
    costs_when_loser << loadout[:cost]
  end
end

p "The least amount of gold you can use to win this fight is #{costs_when_winner.min}g"
p "The most amount of gold you can use to lose this fight is #{costs_when_loser.max}g"
