def find(arr, size, amt)
  arr.combination(size).select { |a| a.inject(:+) == amt }
end

def combinations_of(arr)
  arr.size.times.with_object([]) do |i, o|
    tmp = find(arr, i, 150)
    o << tmp unless tmp.empty?
  end
end

combinations = combinations_of File.read('input').lines.map { |n| n.to_i }
p "The number of different combinations is #{combinations.flatten(1).size}"
p "The number of different ways you can fill the smallest number of containers is #{combinations.first.size}"
