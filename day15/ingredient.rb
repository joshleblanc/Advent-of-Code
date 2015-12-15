class Ingredient
  def initialize(line)
    split_line = line.split
    @capacity = split_line[2].to_i
    @durability = split_line[4].to_i
    @flavor = split_line[6].to_i
    @texture = split_line[8].to_i
    @calories = split_line[10].to_i
  end

  def *(num)
    [@capacity, @durability, @flavor, @texture, @calories].map { |n| n * num }
  end
end
