class MaxIntSet
  def initialize(max)
    @store = [false] * max
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    validate!(num)
    store[num]
  end

  private

  attr_reader :store

  def is_valid?(num)
    num >= 0 && num < store.length
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless self.include?(num)
      self[num] << num
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  attr_reader :store

  def [](num)
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count >= num_buckets
    self.count += 1
    unless self.include?(num)
      self[num] << num
    end
  end

  def remove(num)
    self.count -= 1
    if self.include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  attr_accessor :store
  attr_writer :count

  def [](num)
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = store
    self.store = Array.new(2 * num_buckets) { Array.new }
    self.count = 0
    old_store.each do |bucket|
      bucket.each do |num|
        self.insert(num)
      end
    end
  end
end
