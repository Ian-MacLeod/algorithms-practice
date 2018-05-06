# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    new_node = BSTNode.new(value)
    return self.root = new_node if root.nil?
    current = root
    until current.nil?
      parent = current
      if current.value < value
        current = current.right
      else
        current = current.left
      end
    end
    new_node.parent = parent
    if parent.value < value
      parent.right = new_node
    else
      parent.left = new_node
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    case value <=> tree_node.value
    when 0
      tree_node
    when 1
      find(value, tree_node.right)
    when -1
      find(value, tree_node.left)
    end
  end

  def delete(value)
    node = find(value)
    return if node.nil?

    if node.left.nil? || node.right.nil?
      remove_safe_node(node)
    else
      replacement_node = maximum(node.left)
      remove_safe_node(replacement_node)
      node.value = replacement_node.value
    end
  end

  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?
    [depth(tree_node.left), depth(tree_node.right)].max + 1
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    difference = depth(tree_node.left) - depth(tree_node.right)
    return false if difference.abs > 1
    is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)
    arr
  end

  private

  def remove_safe_node(node)
    if node == root
      if node.left.nil?
        self.root = node.right
        node.right.parent = nil unless node.right.nil?
      else
        self.root = node.left
        node.left.parent = nil unless node.left.nil?
      end
    elsif node.left.nil?
      if node.parent.left == node
        node.parent.left = node.right
      else
        node.parent.right = node.right
      end
      node.right.parent = node.parent if node.right
    elsif node.right.nil?
      if node.parent.left == node
        node.parent.left = node.left
      else
        node.parent.right = node.left
      end
      node.left.parent = node.parent
    end
  end
end
