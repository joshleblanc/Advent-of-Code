def has_disallowed_substring?(str)
  %w(ab cd pq xy).any? { |c| str.include? c }
end

def has_three_vowels?(str)
  vowels = %w(a e i o u)
  str.chars.count { |c| vowels.include? c } >= 3
end

def has_twin_chars?(str)
  str.chars.any? { |c| str.index c * 2 }
end

def is_nice_word?(str)
  has_three_vowels?(str) && has_twin_chars?(str) && !has_disallowed_substring?(str)
end

def has_two_non_overlapping_two_letter_sequences?(str)
  str.chars.each.with_index.any? do |_, i|
    curr = str[i..i.next]
    rest = str.sub(curr, ' ')
    curr.length == 2 && rest.include?(curr)
  end
end

def has_seperated_repeated_letter?(str)
  str.chars.each.with_index.any? do |_, i|
    curr = str[i..i+2].chars
    curr.length == 3 && curr.first == curr.last
  end
end

def is_new_nice_word?(str)

  has_two_non_overlapping_two_letter_sequences?(str) && has_seperated_repeated_letter?(str)
end

def get_num_nice_words
  count = 0
  File.open('input', 'r') do |infile|
    while(line = infile.gets)
      count += 1 if is_nice_word? line.strip
    end
  end
  count
end

def get_num_nice_words_new
  count = 0
  File.open('input', 'r') do |infile|
    while(line = infile.gets)
      count += 1 if is_new_nice_word? line.strip
    end
  end
  count
end

p "Original number of nice words: #{get_num_nice_words}"
p "New number of nice words: #{get_num_nice_words_new}"
