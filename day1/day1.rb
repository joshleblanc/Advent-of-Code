
def calc_floor
  each_floor {}
end

def calc_first_basement
  each_floor do |floor, move|
    return move + 1 if floor < 0
  end
end

def each_floor
  input = File.read('input')
  floor = 0
  input.chars.each_with_index do |char, i|
    floor += 1 if char == '('
    floor -= 1 if char == ')'
    yield floor, i
  end
  floor
end

p "The instructions take santa to floor: #{calc_floor}"
p "Santa enters the basement on move: #{calc_first_basement}"
