require_relative 'operand.rb'

class Instruction
  attr_reader :action, :output, :operands

  ACTIONS = {
    "NOT" => lambda { |a, _| ~a },
    "AND" => lambda { |a, b| a & b },
    "OR" => lambda { |a, b| a | b },
    "RSHIFT" => lambda { |a, b| a >> b },
    "LSHIFT" => lambda { |a, b| a << b },
    "ASSIGN" => lambda { |a, _| a }
  }

  def initialize(str)
    values = str.split
    @output = values.last
    if values.length == 4
      @action = values.first
      @operands = {
        left: Operand.new(values[1]),
        right: Operand.new(nil)
      }
    elsif values.length == 5
      @action = values[1]
      @operands = {
        left: Operand.new(values.first),
        right: Operand.new(values[2])
      }
    else
      @action = "ASSIGN"
      @operands = {
        left: Operand.new(values.first),
        right: Operand.new(nil)
      }
    end
  end

  def ready?
    @operands[:left].fulfilled? && @operands[:right].fulfilled?
  end

  def perform
    ACTIONS[@action].call @operands[:left].value, @operands[:right].value
  end

end
