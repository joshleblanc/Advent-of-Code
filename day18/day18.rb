require 'pp'

def get_board(file)
  board = Hash.new(0)
  y = 0
  File.open(file, 'r') do |infile|
    while (line = infile.gets)
      line.strip.chars.each.with_index do |char, x|
        board[[x, y]] = char == "#" ? 1 : 0
      end
      y += 1
    end
  end
  board
end

def neighbours(board, k)
  x, y = k
  ((x-1)..(x+1)).inject(0) do |sum, i|
    sum + ((y-1)..(y+1)).count do |j|
      board[[i, j]] == 1
    end
  end - board[k]
end

def iterate!(board, buffer, broken=false)
  board.each do |k, v|
    n = neighbours(board, k)
    corners = get_corners(board)
    case v
    when 1
      buffer[k] = 0 unless [2,3].include?(n) || (corners.include?(k) && broken)
    else
      buffer[k] = 1 if n == 3
    end
  end
end

def get_corners(board)
  @width ||= board.keys.max_by(&:last).last
  @height ||= board.keys.max_by(&:first).first
  [
    [0,0],
    [0, @width],
    [@height, 0],
    [@height, @width]
  ]
end

def turn_on_4_corner_lights!(board)
  corners = get_corners(board)
  corners.each do |corner|
    board[corner] = 1
  end
end


board = get_board('input')
broken_board = board.clone
turn_on_4_corner_lights!(broken_board)
buffer = board.clone
broken_buffer = broken_board.clone


100.times do |i|
  iterate!(board, buffer)
  iterate!(broken_board, broken_buffer, true)
  board = buffer.clone
  broken_board = broken_buffer.clone
end

p "#{board.values.count { |v| v == 1 }} lights are on"
p "#{broken_board.values.count { |v| v == 1}} lights are on when broken corner lights"
