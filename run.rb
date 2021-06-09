require_relative './lib/my_inject.rb'
require_relative './lib/inject.rb'

a = []
a1 = [1, 2, 3]

compare(a1.inject(1) {|sum, number| sum + number}, 7 )
override_inject(a)
override_inject(a1)
proc = Proc.new {|accumulator, number| accumulator - number}
p a1.inject(1, proc)