# frozen_string_literal: true

# module for the insert and delete methods of the tree class
module InsertDelete
  def insert(data, current_node = root)
    return nil if current_node && data == current_node.data

    new_node = Node.new(data)

    if root.nil?
      self.root = new_node
    elsif data > current_node.data
      insert_right(data, current_node)
    elsif data < current_node.data
      insert_left(data, current_node)
    end
  end

  def insert_right(data, current_node)
    return current_node.right_node = Node.new(data) if current_node.right_node.nil?

    insert(data, current_node.right_node)
  end

  def insert_left(data, current_node)
    return current_node.left_node = Node.new(data) if current_node.left_node.nil?

    insert(data, current_node.left_node)
  end

  def delete(data, current_node = root)
    return current_node if current_node.nil?
    return nil if current_node.right_node.nil? && current_node.left_node.nil?

    if data > current_node.data
      current_node.right_node = delete(data, current_node.right_node)
    elsif data < current_node.data
      current_node.left_node = delete(data, current_node.left_node)
    else
      current_node = delete_node(current_node)
    end

    current_node
  end

  def delete_node(node)
    if node.left_node.nil?
      return node.right_node
    elsif node.right_node.nil?
      return node.left_node
    end

    successor = find_successor(node.right_node)
    node.data = successor.data
    node.right_node = delete(successor.data, node.right_node)

    node
  end

  def find_successor(node)
    node = node.left_node until node.left_node.nil?
    node
  end
end
