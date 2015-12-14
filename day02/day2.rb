def calc_needed_paper(l, w, h)
  lw, wh, hl = l * w,  w * h, h * l
  2 * (lw + wh + hl) + [lw,wh,hl].min
end

def calc_needed_ribbon(l, w, h)
  2 * [l, w, h].sort.take(2).inject(:+) + l * w * h
end

def each_box
  obj = []
  File.open('input', 'r') do |infile|
    while(line = infile.gets)
      l, w, h = line.split('x').map { |i| i.to_i }
      obj << yield(l, w, h)
    end
  end
  obj.reduce(:+)
end

def calc_total_ribbon
  each_box { |l, w, h| calc_needed_ribbon(l, w, h) }
end

def calc_total_wrapping_paper
  each_box { |l, w, h| calc_needed_paper(l, w, h) }
end

p "Total wrapping paper needed: #{calc_total_wrapping_paper} square feet"
p "Total ribbon needed: #{calc_total_ribbon} feet"
