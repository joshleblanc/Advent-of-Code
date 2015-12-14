require_relative 'reindeer.rb'

reindeer = []

File.open('input', 'r') do |infile|
  while (line = infile.gets)
    reindeer << Reindeer.new(line)
  end
end

2503.times do |i|
  reindeer.each(&:simulate!)
  reindeer.max_by(&:distance).give_point
end
p "The furthest distance is #{reindeer.max_by(&:distance).distance}km"
p "The max points is: #{reindeer.max_by(&:points).points}"
