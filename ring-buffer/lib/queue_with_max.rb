# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store
  attr_reader :maxes

  def initialize
    @store = RingBuffer.new
    @maxes = RingBuffer.new
  end

  def enqueue(val)
    store.push(val)
    until !max || val <= max
      maxes.shift
    end
    maxes.push(val)
  end

  def dequeue
    val = store.shift
    maxes.shift if val == max
    val
  end

  def max
    maxes.length > 0 ? maxes[0] : nil
  end

  def length
    store.length
  end

end
