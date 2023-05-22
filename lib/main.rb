class Node
  attr_accessor :data, :left_node, :right_node

  include Comparable

  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end

  def <=>(other_node)
    self.data <=> other_node.data
  end
end

class Tree
  attr_accessor :root
end
