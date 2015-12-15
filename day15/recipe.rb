class Recipe
  def initialize
    @ingredients = []
    @totals = []
  end

  def add(ingredient)
    @ingredients << ingredient
  end

  def calc_totals!
    @totals = possible_combinations.map do |a|
      totals = calc_totals(a)
      {
        score: calc_score(totals),
        calories: totals.last
      }
    end
  end

  def highest_score(cal_limit=nil)
    totals = @totals
    totals.select! { |a| a[:calories] == 500 } if cal_limit
    totals.max_by { |a| a[:score] }[:score]
  end

  private
  def possible_combinations
    100.times.to_a.permutation(@ingredients.size).select { |a| a.inject(:+) == 100 }
  end

  def calc_totals(a)
    @ingredients.map.with_index { |ing, ind| ing * a[ind] }.transpose.map { |n| [n.inject(:+), 0].max }
  end

  def calc_score(totals)
    totals.first(4).inject(:*)
  end
end
