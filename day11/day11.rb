def has_one_increasing_straight_of_3_chars(str)
  str.chars.each_cons(3) do |chars|
    return true if chars[2] == chars[1].next && chars[1] == chars[0].next
  end
end

def has_illegal_chars(str)
  !!str[/i|l|o/]
end

def has_two_non_overlapping_char_pairs(str)
  str.chars.each_cons(2).select do |chars|
    chars.join[/(.)\1/]
  end.map(&:join).uniq.size > 1
end

def is_valid?(str)
  has_one_increasing_straight_of_3_chars(str) &&
  !has_illegal_chars(str) &&
  has_two_non_overlapping_char_pairs(str)
end

def next_password(str)
  str = str.next while !is_valid? str
  str
end

input = File.read('input').strip
new_pass = next_password(input)
p "Santa's new password is: #{new_pass}"
p "Santa's next password is: #{next_password(new_pass.next)}"
