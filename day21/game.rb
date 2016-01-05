class Game

  attr_reader :hero, :winner
  def initialize(hero, boss)
    @hero = hero
    @boss = boss
  end

  def reset!
    @hero.heal!
    @boss.heal!
  end

  def sim!
    loop do
      @hero.attack!(@boss)
      @boss.attack!(@hero)
      if @boss.dead?
        return @hero
      elsif @hero.dead?
        return @boss
      end
    end
  end

  def state
   puts "Hero: #{@hero.to_s}"
   puts "Boss: #{@boss.to_s}"
  end
end
