require 'pp'

def parse(line)
  split_line = line.split
  {
    "#{split_line[0]}".to_sym => split_line[1].chomp(":").to_i,
    "#{split_line[2].chomp(':')}".to_sym => split_line[3].to_i,
    "#{split_line[4].chomp(':')}".to_sym => split_line[5].to_i,
    "#{split_line[6].chomp(':')}".to_sym => split_line[7].to_i

  }
end

def get_aunt_num
  aunt = [
    "children: 3,",
    "cats: 7,",
    "samoyeds: 2,",
    "pomeranians: 3,",
    "akitas: 0,",
    "vizslas: 0,",
    "goldfish: 5,",
    "trees: 3,",
    "cars: 2,",
    "perfumes: 1,"
  ].combination(3)
  File.read('input').lines.select { |line| aunt.any? { |a| a.all? { |b| line.sub("\n", ',').include? b } } }.join.split[1].chomp(':')
end

def get_new_aunt_num
  aunt = {
    children: 3,
    cats: 7,
    samoyeds: 2,
    pomeranians: 3,
    akitas: 0,
    vizslas: 0,
    goldfish: 5,
    trees: 3,
    cars: 2,
    perfumes: 1
  }.to_a.combination(3)
  File.read('input').lines.select do |line|
    line = parse(line)
    aunt.any? do |a|
      a.all? do |b|
        case b.first
        when :cats, :trees
          line[b.first] && line[b.first] > b.last
        when :pomeranians, :goldfish
          line[b.first] && line[b.first] < b.last
        else
          line[b.first] && line[b.first] == b.last
        end
      end
    end
  end.join.split[1].chomp(':')
end



p "The letter came from aunt #{get_aunt_num}"
p "The letter came from aunt #{get_new_aunt_num}"
