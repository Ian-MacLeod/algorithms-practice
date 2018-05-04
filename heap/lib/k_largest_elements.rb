require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  
  array.each do |el|
    heap.push(el)
    if heap.count > k
      heap.extract
    end
  end

  result = []
  until heap.count == 0
    result << heap.extract
  end

  result
end
