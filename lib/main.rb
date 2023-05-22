class Node
  attr_accessor :data, :left_node, :right_node

  include Comparable

  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end

  def <=>(other_node)
    self.data <=> other_node.data if other_node
  end
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end

  def insert(data, current_node = root)
    return nil if data == current_node.data
    new_node = Node.new(data)

    if data > current_node.data
      return current_node.right_node = new_node if current_node.right_node == nil

      insert(data, current_node.right_node)
    elsif data < current_node.data
      return current_node.left_node = new_node if current_node.left_node == nil

      insert(data, current_node.left_node)
    end
  end

  def delete(data, current_node = root)
    return current_node if current_node.nil?
    return nil if current_node.right_node.nil? && current_node.left_node.nil?

    if data > current_node.data
      current_node.right_node = delete(data, current_node.right_node)
    elsif data < current_node.data
      current_node.left_node = delete(data, current_node.left_node)
    else
      if current_node.left_node.nil?
        return current_node.right_node
      elsif current_node.right_node.nil?
        return current_node.left_node
      end

      successor = find_successor(current_node.right_node)
      current_node.data = successor.data
      current_node.right_node = delete(successor.data, current_node.right_node)
    end

    current_node
  end

  def find_successor(node)
    node = node.left_node until node.left_node.nil?
    node
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

  def level_order(node = root, &block)
    return if node.nil?

    queue = []
    level_order_array = []
    queue << node

    until queue.empty?
      current = queue.shift
      block.call current if block_given?
      level_order_array << current.data

      queue << current.left_node if current.left_node
      queue << current.right_node if current.right_node
    end

    level_order_array
  end

  def inorder(current_node = root, inorder_array = [], &block)
    return if current_node.nil?

    inorder(current_node.left_node, inorder_array, &block)

    block.call current_node if block_given?
    inorder_array << current_node.data

    inorder(current_node.right_node, inorder_array, &block)

    inorder_array
  end

  def preorder(current_node = root, preorder_array = [], &block)
    return if current_node.nil?

    block.call current_node if block_given?
    preorder_array << current_node.data

    preorder(current_node.left_node, preorder_array, &block)
    preorder(current_node.right_node, preorder_array, &block)

    preorder_array
  end

  def postorder(current_node = root, postorder_array = [], &block)
    return if current_node.nil?

    postorder(current_node.left_node, postorder_array, &block)
    postorder(current_node.right_node, postorder_array, &block)

    block.call current_node if block_given?
    postorder_array << current_node.data

    postorder_array
  end

  def height(node)
    return 0 if node.nil?

    left_height = height(node.left_node)
    right_height = height(node.right_node)

    [left_height, right_height].max + 1
  end

  def depth(node, current_depth)
    return 0 if node == current_node

    if node.data > current_node.data
      node_depth = depth(node, current_node.right_node)
    elsif node.data < current_node.data
      node_depth = depth(node, current_node.left_node)
    end

    node_depth + 1
  end
end
