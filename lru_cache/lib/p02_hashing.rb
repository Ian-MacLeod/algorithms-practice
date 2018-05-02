class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = 0
    each_with_index do |el, idx|
      hash ^= el.hash * idx
    end
    hash
  end
end

class String
  def hash
    return ord.hash if length == 1
    chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort.hash
  end
end
