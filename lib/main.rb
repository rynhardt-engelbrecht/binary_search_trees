# frozen_string_literal: true

require_relative 'tree'

arr = Array.new(15) { rand(1..100) } # Generate random array
tree = Tree.new
tree.build_tree(arr) # Construct tree
puts tree
tree.pretty_print
puts "\nBalanced: #{tree.balanced?}"
puts "\nLevel-order: #{tree.level_order.join(', ')}"
puts "\nIn-order: #{tree.inorder.join(', ')}"
puts "\nPre-order: #{tree.preorder.join(', ')}"
puts "\nPost-order: #{tree.postorder.join(', ')}"
5.times { tree.insert rand(100..200) } # Insert 5 random values to tree
puts tree
tree.pretty_print
puts "\nBalanced: #{tree.balanced?}"
tree.rebalance
puts tree
tree.pretty_print
puts "\nBalanced: #{tree.balanced?}"
puts "\nLevel-order: #{tree.level_order.join(', ')}"
puts "\nIn-order: #{tree.inorder.join(', ')}"
puts "\nPre-order: #{tree.preorder.join(', ')}"
puts "\nPost-order: #{tree.postorder.join(', ')}"
