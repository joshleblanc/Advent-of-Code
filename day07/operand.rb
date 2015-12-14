class Operand
  attr_reader :key, :value
  attr_writer :value

  def initialize(str)
    @key = str
    @fulfilled = false
    if is_numeric? str
      @fulfilled = true
      @value = Integer(str)
    elsif str.nil?
      @fulfilled = true
    end
  end

  def update!(wires)
    @value = wires[key]
    @fulfilled = true
  end

  def unfulfilled?
    !@fulfilled
  end

  def fulfilled?
    @fulfilled
  end

  private
  def is_numeric?(str)
    true if Integer(str) rescue false
  end
end
