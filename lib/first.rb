def compare value, expected
  return if value == expected
  puts "#{value.inspect} received, expecting #{expected.inspect}"
end

def override_first(enumerable)
  def enumerable.first(n = nil)
    is_empty = true

    result = []
    each do |item|
      return item if n.nil?
      is_empty = false

      result << item
      return result if result.length == n
    end
    return result unless is_empty

    # If n is nil result is a value, else an array
    n.nil? ? nil : []
  end
end

a1 = %w[foo bar baz]
a2 = []

compare(a1.first(2), ["", "bar"])
compare(a1.first(2), ["foo", "bar"])
compare(a1.first(10), ["foo", "bar", "baz"])
compare(a2.first, nil)
compare(a2.first(10), [])
override_first(a1)
override_first(a2)
compare(a1.first(2), ["foo", "bar"])
compare(a1.first(10), ["foo", "bar", "baz"])
compare(a2.first, nil)
compare(a2.first(10), [])
