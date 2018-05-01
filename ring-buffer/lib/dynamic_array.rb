require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    self.length -= 1
    store[length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity
    store[length] = val
    self.length += 1
    self
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0
    shifted = store[0]
    (0...length - 1).each do |idx|
      store[idx] = store[idx + 1]
    end
    self.length -= 1
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity
    length.downto(1).each do |idx|
      store[idx] = store[idx - 1]
    end
    store[0] = val
    self.length += 1
    self
  end

  protected

  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if index < 0 || index >= length
      raise "index out of bounds"
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    old_store = store
    self.store = Array.new(capacity * 2)
    length.times do |idx|
      store[idx] = old_store[idx]
    end
    self.capacity *= 2
  end
end
