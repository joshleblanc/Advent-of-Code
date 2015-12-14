class Reindeer
  attr_reader :distance, :points
  def initialize(line)
    split_line = line.split
    @flying_time = split_line[6].to_i
    @standing_time = split_line[13].to_i
    @flying_speed = split_line[3].to_i
    @distance = 0
    @current_second = 1
    @flying = true
    @points = 0
  end

  def simulate!
    @flying ? fly! : rest!
    @current_second += 1
  end

  def give_point
    @points += 1
  end

  private
  def fly!
    @distance += @flying_speed
    if @current_second == @flying_time
      @flying = false
      @current_second = 0
    end
  end

  def rest!
    if @current_second == @standing_time
      @flying = true
      @current_second = 0
    end
  end
end
