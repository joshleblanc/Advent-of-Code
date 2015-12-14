class InstructionQueue

  def initialize
    @queue = []
  end

  def push(instruction)
    @queue << instruction
  end

  def each_ready
    @queue.each do |i|
      if i.ready?
        yield(i)
        @queue.delete i
      end
    end
  end

  def update!(wires)
    @queue.each do |i|
      if wires.include? i.operands[:right].key
        i.operands[:right].update!(wires)
      end
      if wires.include? i.operands[:left].key
        i.operands[:left].update!(wires)
      end
    end
  end

  def empty?
    @queue.empty?
  end

end
