require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if map.include?(key)
      map[key].val
      update_node!(map[key])
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  attr_reader :map, :store, :max, :prc

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    result = prc.call(key)
    map[key] = store.append(key, result)
    eject! if map.count > max
    result
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    store.append_node(node.remove)
  end

  def eject!
    node = store.first
    node.remove
    map.delete(node.key)
  end
end
