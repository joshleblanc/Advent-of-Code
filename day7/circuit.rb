require_relative 'instruction_queue.rb'

class Circuit

  def initialize
    @queue = InstructionQueue.new
    @wires = {}
    @overrides = {}
  end

  def get(str)
    @wires[str]
  end

  def set(str, val)
    @wires[str] = val
  end

  def reset!
    @queue = InstructionQueue.new
    @wires = {}
  end

  def process!
    while !complete?
      @queue.each_ready do |ins|
        @wires[ins.output] ||= ins.perform
      end
      @queue.update! @wires
    end
  end

  def consume(i)
    @queue.push i
  end

  def consume_from_file(file)
    File.open(file, 'r') do |infile|
      while(line = infile.gets)
        consume Instruction.new line.strip
      end
    end
  end

  def complete?
    @queue.empty?
  end
end
