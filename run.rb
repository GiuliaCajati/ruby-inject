require_relative './lib/my_inject.rb'
require_relative './lib/inject.rb'

a = []
a1 = [1, 2, 3]
code_block = Proc.new {|accumulator, number| accumulator + number}

#inject.rb solution 
compare(a1.inject(1) {|sum, number| sum + number}, 7 )
override_inject(a)
override_inject(a1)
compare(a1.inject(1, code_block), 7)

#my_inject.rb solution 
my_array = Array.new([1,2,3])
callback = lambda do |sum, num|
  sum * num
end

compare(my_array.my_inject(5, &callback), my_array.inject(5, &callback) )


