
def kth_largest(tree_node, k)
  count = 1
  path = [["pre", tree_node]]
  until path.empty?
    type, current = path.pop
    if type == "in"
      return current if count == k
      count += 1
    else
      path << ["pre", current.left] unless current.left.nil?
      path << ["in", current]
      path << ["pre", current.right] unless current.right.nil?
    end
  end
  nil
end
