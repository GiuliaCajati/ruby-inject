def compare value, expected
  # return if value == expected
  puts "#{value.inspect} received, expecting #{expected.inspect}"
end

def override_inject(enumerable)

  def enumerable.inject(initValue, block)
    accumulator = initValue
    
    each do |element|
      accumulator = block.call(accumulator, element)
    end   

    return accumulator
  end
end

a = []
a1 = [1, 2, 3]

compare(a1.inject(1) {|sum, number| sum + number}, 7 )
override_inject(a)
override_inject(a1)
proc = Proc.new {|accumulator, number| accumulator - number}
p a1.inject(1, proc)
