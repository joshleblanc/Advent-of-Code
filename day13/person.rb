class Person
  attr_reader :name, :relationships
  def initialize(line)
    if line.split.length > 1
      @name, @relationships = parse(line)
    else
      @name = line
      @relationships = {}
    end
  end

  def add_relationship(rel)
    @relationships[rel.first] = rel.last
  end

  private
  def parse(line)
    split_line = line.split
    name = split_line.first
    sign = split_line[2] == 'lose' ? -1 : 1
    rel = {
      split_line.last.chomp('.') => split_line[3].to_i * sign
    }
    [name, rel]
  end
end
