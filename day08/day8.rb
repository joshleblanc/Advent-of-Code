num_chars_mem = 0
num_chars_str_lit = 0
num_enc_str = 0

File.open('input', 'r') do |infile|
  while(line = infile.gets)
    num_chars_mem += eval(line).length
    num_chars_str_lit += line.strip.length
    num_enc_str += line.strip.inspect.length
  end
end

p "The number of characters of code for string ltierals minus the number of characters in memory for the values of the strings is: #{num_chars_str_lit - num_chars_mem}"
p "The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is #{num_enc_str - num_chars_str_lit}"
