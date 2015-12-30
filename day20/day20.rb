require 'prime'

# http://stackoverflow.com/a/3398195/2424975
def divisors_of(number)
  primes, powers = number.prime_division.transpose
  exponents = powers.map{ |i| (0..i).to_a}
  divisors = exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map{|prime, power| prime ** power}.inject(:*)
  end
  divisors
end

def find(num)
  2.upto(num / 10).find do |i|
    divisors_of(i).inject(:+) * 10 >= num
  end
end

def find_with_lazy_elves(num)
  times_delivered = []
  2.upto(num / 10).find do |i|
    divisors_of(i).select do |div|
      times_delivered[div] ||= -1
      times_delivered[div] += 1
      times_delivered[div] <= 50
    end.inject(:+) * 11 >= num
  end
end

input = File.read('input').strip.to_i
p "The lowest house number to get at least #{input} presents is #{find(input)}"
p "The lowest house number to get at least #{input} presents with lazy elves is #{find_with_lazy_elves(input)}"
