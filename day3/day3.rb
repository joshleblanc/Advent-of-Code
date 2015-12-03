def next_position(last, dir)
  moves = {'>' => [1, 0], '<' => [-1, 0], '^' => [0, -1], 'v' => [0, 1] }
  {
    x: last[:x] + moves[dir].first,
    y: last[:y] + moves[dir].last
  }
end

def calc_num_uniq_vists
  visited = move([{x: 0, y: 0}]) { |dir, obj| obj << next_position(obj.last, dir) }
  visited.uniq.count
end

def move(obj)
  dirs = File.read('input').strip
  dirs.chars.each_with_object(obj).with_index do |(dir, object), ind|
    yield(dir, object, ind)
  end
end

def calc_num_uniq_vists_with_robo_santa
  moves = move({santa:[{x:0,y:0}],robo:[{x:0,y:0}]}) do |dir, obj, ind|
    if ind.odd?
      obj[:santa] << next_position(obj[:santa].last, dir)
    else
      obj[:robo] << next_position(obj[:robo].last, dir)
    end
  end
  (moves[:santa] + moves[:robo]).uniq.count
end

p "#{calc_num_uniq_vists} houses recieved at least one visit from santa"
p "#{calc_num_uniq_vists_with_robo_santa} houses recieved at least one visit from from santa or robo santa"
