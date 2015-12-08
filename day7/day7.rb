require_relative 'circuit.rb'
require_relative 'instruction.rb'

circuit = Circuit.new
circuit.consume_from_file 'input'
circuit.process!
a_signal = circuit.get 'a'
p "The signal of wire a is #{a_signal}"

circuit.reset!
circuit.consume_from_file 'input'
circuit.set("b", a_signal)
circuit.process!
p "The signal of wire a when b is overridden is #{circuit.get('a')}"
