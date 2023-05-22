# frozen_string_literal: true

# node class for binary search tree
class Node
  attr_accessor :data, :left_node, :right_node

  include Comparable

  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end

  def <=>(other)
    data <=> other.data if other
  end
end
