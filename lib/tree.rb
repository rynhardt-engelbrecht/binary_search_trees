# frozen_string_literal: true

require_relative 'node'
require_relative 'binary_tree_traversals'
require_relative 'insertion_deletion'

# binary search tree class
class Tree
  attr_accessor :root

  include Traversals
  include InsertDelete

  def build_tree(array)
    return nil if array.empty?

    sort_and_uniq_array(array) if root.nil?

    build_tree_recursive(array)
  end

  def sort_and_uniq_array(array)
    array.uniq!
    array.sort!
  end

  def build_tree_recursive(array)
    return if array.empty?

    middle = array.length / 2
    node = Node.new(array[middle])
    self.root = node if root.nil?

    node.left_node = build_tree_recursive(array.slice(0, middle))
    node.right_node = build_tree_recursive(array.slice(middle + 1, array.length))

    node
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left_node
  end

  def find(data, current_node = root)
    return current_node if data == current_node.data
    return nil if current_node.right_node.nil? && current_node.left_node.nil?

    if data > current_node.data
      find(data, current_node.right_node)
    elsif data < current_node.data
      find(data, current_node.left_node) if data < current_node.data
    end
  end

  def height(node)
    return 0 if node.nil?

    [height(node.left_node), height(node.right_node)].max + 1
  end

  def depth(node)
    return 0 if node == current_node

    if node.data > current_node.data
      node_depth = depth(node, current_node.right_node)
    elsif node.data < current_node.data
      node_depth = depth(node, current_node.left_node)
    end

    node_depth + 1
  end

  def balanced?(node = root)
    return true if node.nil?

    left_height = height(node.left_node)
    right_height = height(node.right_node)

    return true if (left_height - right_height) <= 1 && balanced?(node.left_node) == true && balanced?(node.right_node)

    false
  end

  def rebalance
    tree_array = level_order
    self.root = nil
    build_tree(tree_array)
  end
end
