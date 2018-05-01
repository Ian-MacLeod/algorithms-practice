require_relative "static_array"
require "byebug"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @start_idx = 0
    @length = 0
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    check_index(index)
    store[store_index(index)]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    store[store_index(index)] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    self.length -= 1
    store[store_index(length)]
  end

  # O(1) ammortized
  def push(val)
    resize! if length == capacity
    self.length += 1
    self[length - 1] = val
    self
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0
    shifted = self[0]
    self.start_idx = (start_idx + 1) % capacity
    self.length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == capacity
    self.length += 1
    self.start_idx = (start_idx - 1) % capacity
    self[0] = val
    self
  end

  protected

  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def store_index(index)
    (start_idx + index) % capacity
  end

  def check_index(index)
    if index < 0 || index >= length
      raise "index out of bounds"
    end
  end

  def resize!
    new_store = StaticArray.new(capacity * 2)
    (0...length).each do |idx|
      new_store[idx] = self[idx]
    end
    self.store = new_store
    self.capacity *= 2
    self.start_idx = 0
  end
end
