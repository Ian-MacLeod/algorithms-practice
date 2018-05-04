class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    pivot = array.first
    left = sort1(array.drop(1).select { |el| el < pivot })
    right = sort1(array.drop(1).select { |el| el >= pivot })
    left + [pivot] + right
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1
    pivot = partition(array, start, length, &prc)
    self.sort2!(array, start, pivot - start, &prc)
    self.sort2!(array, pivot + 1, length - pivot + start - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot = array[start]
    barrier = start + 1
    current = start + 1
    while current < start + length
      if prc.call(array[current], pivot) == -1
        array[barrier], array[current] = array[current], array[barrier]
        barrier += 1
      end
      current += 1
    end
    array[start], array[barrier - 1] = array[barrier - 1], array[start]
    barrier - 1
  end
end
