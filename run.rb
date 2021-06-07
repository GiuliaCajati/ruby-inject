def compare value, expected
  # return if value == expected
  puts "#{value.inspect} received, expecting #{expected.inspect}"
end

def override_inject(enumerable)
  def enumerable.inject(input = nil)
    result = 0
    if input.class == Symbol
      each do |item|
        result += item
      end 
    end
    return result
  end
end

a = []
a1 = [1, 2, 3]

compare(a.inject(:+), nil)
compare(a1.inject(:+), 6)
override_inject(a)
override_inject(a1)
compare(a.inject(:+), nil)
compare(a1.inject(:+), 6)