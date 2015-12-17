containers = File.read('input').lines.map{ |n| n.to_i }
combinations = containers.size.times.with_object([]) { |i, o| o << containers.combination(i).select { |a| a.inject(:+) == 150 } }.reject { |n| n.empty? }

p "The number of different combinations is #{combinations.flatten(1).size}"
p "The number of different ways you can fill the smallest number of containers is #{combinations.first.size}"
