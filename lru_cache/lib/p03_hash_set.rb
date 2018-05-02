require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count >= num_buckets
    unless self.include?(key)
      self[key] << key
    end
    self.count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
    end
    self.count -= 1
  end

  private
  attr_writer :count
  attr_accessor :store

  def [](num)
    store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = store
    self.store = Array.new(2 * num_buckets) { Array.new }
    self.count = 0
    old_store.each do |bucket|
      bucket.each do |el|
        self.insert(el)
      end
    end
  end
end
