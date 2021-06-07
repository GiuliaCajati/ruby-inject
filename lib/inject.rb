def compare value, expected
  return if value == expected
  puts "#{value.inspect} received, expecting #{expected.inspect}"
end

def override_inject(enumerable)
  def enumerable.inject(n = nil)
    is_empty = true

    result = []
    each do |item|
      return item if n.nil? #if empty return nil 
      is_empty = false

      result << item
      return result if result.length == n
    end
    return result unless is_empty

    # If n is nil result is a value, else an array
    n.nil? ? nil : []
  end
end

a1 = [1, 2, 3]

compare(inject(a1, :+), 6)
