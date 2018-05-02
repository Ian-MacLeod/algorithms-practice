require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if count >= num_buckets
    if bucket(key).include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      self.count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    self.count -= 1
  end

  def each
    store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  attr_accessor :store
  attr_writer :count

  def num_buckets
    @store.length
  end

  def resize!
    old_store = store
    self.store = Array.new(2 * num_buckets) { LinkedList.new }
    self.count = 0
    old_store.each do |bucket|
      bucket.each do |node|
        self.set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    store[key.hash % num_buckets]
  end
end
