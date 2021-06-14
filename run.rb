require_relative './lib/my_inject.rb'
require_relative './lib/inject.rb'

a = []
a1 = [1, 2, 3]
code_block = Proc.new {|accumulator, number| accumulator + number}


#inject.rb solution 
compare(a1.inject(1) {|accumulator, number| accumulator + number}, 7 )
override_inject(a)
override_inject(a1)
compare(a1.inject(1, code_block), 7)

#my_inject.rb solution 
my_array = Array.new([1,2,3])
array_key_value = Array.new([[:key1, "Value1"],[:key2, "Value2"], [:key3, "Value3"]])

sum_callback = lambda do |accumulator, num|
  accumulator * num
end

hash_callback = lambda do |my_hash, element|
  my_hash[element[0]] = element[1]
end

compare(my_array.my_inject(5, &sum_callback), my_array.inject(5, &sum_callback) )

# working on 
# p array_key_value.my_inject({}, &hash_callback)