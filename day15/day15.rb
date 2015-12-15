require_relative 'ingredient.rb'
require_relative 'recipe.rb'

recipe = Recipe.new

File.open('input', 'r') do |infile|
  while (line = infile.gets)
    recipe.add(Ingredient.new(line))
  end
end

recipe.calc_totals!
p "The highest score for the cookies is: #{recipe.highest_score}"
p "The highest score for cookies with 500 calories is #{recipe.highest_score(500)}"
