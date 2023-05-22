class Node
  attr_accessor :data, :left_node, :right_node

  include Comparable

  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end

  # def <=>(other_node)
  #   self.data <=> other_node.data
  # end
end

class Tree
  attr_accessor :root

  def build_tree(array)
    return nil if array.empty?

    if root == nil
      array.uniq!
      array.sort!
    end

    middle = array.length/2
    node = Node.new(array[middle])
    self.root = node if root == nil

    node.left_node = build_tree(array.slice(0, middle))
    node.right_node = build_tree(array.slice(middle + 1, array.length))

    return node
  end
end
