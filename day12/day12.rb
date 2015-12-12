require 'json'
require 'pp'

def get_sum_all_numbers(input)
  input.scan(/-?\d+/).map(&:to_i).inject(:+)
end

def find_red_obj(input)
	red = []
	case input
	when Array
		input.each do |i|
			red << find_red_obj(i)
		end
	when Hash
		if input.values.include? "red"
			return input.to_s
		else
			input.values.each do |v|
				red << find_red_obj(v)
			end
		end
	end
	return red.flatten
end


input = File.read('input')
sum_all_nums = get_sum_all_numbers(input)
p "The sum of all numbers is #{sum_all_nums}"

json = JSON.parse(input)
sum_red = find_red_obj(json).inject(0) do |sum, red|
	sum + get_sum_all_numbers(red)
end

p "Sum with reds removed is: #{sum_all_nums - sum_red}"

