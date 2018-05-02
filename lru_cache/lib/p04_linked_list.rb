class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    self.next.prev = self.prev
    self.prev.next = self.next
    self
  end
end

class LinkedList
  attr_reader :head, :tail
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    self.head.next = self.tail
    self.tail.prev = self.head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    node = find(key)
    node && node.val
  end

  def include?(key)
    !!find(key)
  end

  def append(key, val)
    node = Node.new(key, val)
    append_node(node)
  end

  def append_node(node)
    node.prev = tail.prev
    node.next = tail
    tail.prev.next = node
    tail.prev = node
    node
  end

  def update(key, val)
    node = find(key)
    node && find(key).val = val
  end

  def remove(key)
    node = find(key)
    node && node.remove
  end

  def each
    current = head.next
    until current == tail
      yield current
      current = current.next
    end
  end

  private

  def find(key)
    current = head.next
    until current == tail
      return current if current.key == key
      current = current.next
    end
    nil
  end

  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
