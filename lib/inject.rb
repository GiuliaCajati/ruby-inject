
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


