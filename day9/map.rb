require 'set'

class Map
  def initialize
    @distances = {}
  end

  def init_from_file(file)
    File.open(file, 'r') do |infile|
      while(line = infile.gets)
        cities, distance = parse(line)
        @distances[cities.to_set] = distance
      end
    end
  end

  def shortest_path
    calc_all_paths.min
  end

  def longest_path
    calc_all_paths.max
  end

  private
  def parse(str)
    s = str.split
    [[s.first, s[2]], Integer(s.last)]
  end

  def calc_all_paths
    all_routes = @distances.map {|k,v| k.to_a}.to_a.flatten.uniq.permutation.to_a
    all_routes.each.with_object([]) do |cities, dists|
      dists << calc_dist(cities)
    end
  end

  def calc_dist(cities)
    cities.each_cons(2).with_object([]) do |(o, t), sum|
      sum << get_dist(o, t)
    end.inject(:+)
  end

  def get_dist(one, two)
    @distances[[one,two].to_set].to_i
  end
end
