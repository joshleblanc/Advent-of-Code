require_relative 'map.rb'

map = Map.new
map.init_from_file 'input'
p "The shortest path to take has a distance of #{map.shortest_path}"
p "The longest path to take has a distance of #{map.longest_path}"
