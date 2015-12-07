class LightGrid
  def initialize(width, height)
    @array = height.times.map do
      [0] * width
    end
  end

  def total_brightness
    @array.inject(0) { |sum, a| sum + a.inject(:+) }
  end

  def parse_instructions(i)
    i.sub! 'turn ', ''
    i = i.split ' '
    i[1] = i[1].split(',').map(&:to_i)
    i[3] = i[3].split(',').map(&:to_i)
    {
      action: i.first,
      start: {
        x: i[1].first,
        y: i[1].last
      },
      finish: {
        x: i[3].first,
        y: i[3].last
      }
    }
  end

  def update!(start, finish, val=nil)
    (start[:x]..finish[:x]).each do |x|
      (start[:y]..finish[:y]).each do |y|
        @array[x][y] = val ? val : yield(@array[x][y])
      end
    end
  end

  def toggle!(start, finish)
    update!(start, finish) { |val|
      (val-1).abs
    }
  end

  def on!(start, finish)
    update!(start, finish, 1)
  end


  def off!(start, finish)
    update!(start, finish, 0)
  end

  def increase_brightness!(start, finish, amt = 1)
    update!(start, finish) { |val| val + amt }
  end

  def decrease_brightness!(start, finish)
    update!(start, finish) { |val| val == 0 ? 0 : val - 1}
  end

  def do(instruction_line)
    ins = parse_instructions instruction_line
    case ins[:action]
    when 'toggle'
      toggle! ins[:start], ins[:finish]
    when 'on'
      on! ins[:start], ins[:finish]
    when 'off'
      off! ins[:start], ins[:finish]
    end
  end

  def corrected_do(instruction_line)
    ins = parse_instructions instruction_line
    case ins[:action]
    when 'toggle'
      increase_brightness! ins[:start], ins[:finish], 2
    when 'on'
      increase_brightness! ins[:start], ins[:finish]
    when 'off'
      decrease_brightness! ins[:start], ins[:finish]
    end
  end

  def print_grid
    @array.each do |a|
      p a
    end
  end

end

lights = LightGrid.new(1000, 1000)
corrected_lights = LightGrid.new(1000, 1000)
File.open('input', 'r') do |infile|
  while(line = infile.gets)
    lights.do(line)
    corrected_lights.corrected_do(line)
  end
end

p "The total number of active lights is: #{lights.total_brightness}"
p "The total brightness of the lights after correction is: #{corrected_lights.total_brightness}"
