# frozen_string_literal: true

# module for all traversal methods of the binary tree
module Traversals
  # rubocop:disable Metrics/MethodLength
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
  # rubocop:enable Metrics/MethodLength

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
end
