require_relative "heap"

class Array
  def heap_sort!
    reverse = Proc.new { |x, y| y <=> x }

    each_index do |idx|
      BinaryMinHeap.heapify_up(self, idx, &reverse)
    end
    
    (count - 1).downto(1) do |idx|
      self[0], self[idx] = self[idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, idx, &reverse)
    end

    self
  end
end
