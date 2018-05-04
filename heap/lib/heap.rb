class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc || Proc.new { |x, y| x <=> y }
    @store = []
  end

  def count
    store.length
  end

  def extract
    store[0], store[-1] = store[-1], store[0]
    self.class.heapify_down(store, 0, count - 1, &prc)
    store.pop
  end

  def peek
    store.first
  end

  def push(val)
    store << val
    self.class.heapify_up(store, count - 1, &prc)
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    current = parent_idx
    min_child = child_indices(len, current).min do |i, j|
      prc.call(array[i], array[j])
    end

    while min_child && prc.call(array[current], array[min_child]) == 1
      array[current], array[min_child] = array[min_child], array[current]
      current = min_child
      min_child = child_indices(len, current).min do |i, j|
        prc.call(array[i], array[j])
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    current = child_idx

    while current > 0
      parent = parent_index(current)
      break if prc.call(array[current], array[parent]) >= 0
      array[current], array[parent] = array[parent], array[current]
      current = parent
    end

    array
  end

  def self.child_indices(len, parent_index)
    [parent_index * 2 + 1, parent_index * 2 + 2].select { |idx| idx < len }
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end
end
