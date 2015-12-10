def calc_look_and_say_sequence(input, iterations)
  iterations.times do
    input = input.gsub(/(.)\1*/) { |m| m.size.to_s + m[0] }
  end
  input
end

input = File.read('input').strip
p "The length of the look and say sequence after 40 iterations is #{calc_look_and_say_sequence(input, 40).size}"
p "The length of the look and say sequence after 50 iterations is #{calc_look_and_say_sequence(input, 50).size}"
