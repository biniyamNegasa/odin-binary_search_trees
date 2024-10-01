# frozen_string_literal: true

require_relative 'lib/binary_search_tree'

# array = Array.new(15) { rand(1..100)}
# tree = Tree.new(array)
# tree.pretty_print
# p array

# puts tree.height
# puts tree.balanced?

# p tree.level_order
# puts 'preorder'
# p tree.preorder
# puts 'inorder'
# p tree.inorder
# puts 'postorder'
# p tree.postorder

# 100.times do |val|
#   tree.insert(val + 256)
# end

# puts tree.pretty_print
# puts tree.balanced?
# tree.rebalance
# tree.pretty_print
# puts tree.balanced?

# p tree.level_order
# puts 'preorder'
# p tree.preorder
# puts 'inorder'
# p tree.inorder
# puts 'postorder'
# p tree.postorder

# tree = Tree.new([24, 53, 2, 9, 33, 35, 97, 15, 34, 83, 79, 10, 5, 42, 72])
# tree.pretty_print

# tree.insert(20)
# tree.pretty_print
# tree.delete(72)
# tree.pretty_print
# tree.delete(9)
# tree.pretty_print
# puts tree.depth(33)
# puts tree.height

# p tree.inorder

# tree.inorder { |data| print "#{data} " }

# p tree.level_order

# tree.level_order { |data| print "#{data} " }
# puts
# tree.delete(34)
# tree.pretty_print
# tree.delete(24)
# tree.pretty_print
# tree.delete(20)
# tree.pretty_print
# tree.delete(15)
# tree.pretty_print
# tree.delete(10)
# tree.pretty_print
