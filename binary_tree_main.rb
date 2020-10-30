require_relative "binary_tree.rb"

array = Array.new(15) { rand(1..100) }

t = Tree.new(array)
puts "original tree"
puts ""
t.inorder([])
puts "--------------------------------"
puts ""
puts "insert"
puts ""
t.insert(100)
t.inorder([])
puts "--------------------------------"
puts ""
puts "delete"
puts ""
t.delete(51)
t.inorder([])
puts "--------------------------------"
puts ""
puts "find"
puts ""
t.find(13)
t.level_order([])
puts "--------------------------------"
puts ""
puts "preorder"
puts ""
t.preorder([])
puts "--------------------------------"
puts ""
puts "postorder"
puts ""
t.postorder([])
puts "--------------------------------"
puts ""
puts "height"
puts ""
t.height(100)
puts "--------------------------------"
puts ""
puts "depth"
puts ""
t.depth
puts "--------------------------------"
puts ""
puts "insert"
puts ""
t.insert(900)
puts "--------------------------------"
puts ""
puts "balanced?"
puts ""
t.balanced?
puts "--------------------------------"
puts ""
puts "rebalance"
puts ""
t.rebalance
puts "--------------------------------"
puts ""
puts "balanced?"
puts ""
t.balanced?
puts "--------------------------------"
puts ""
puts "final inorder"
puts ""
t.inorder([])
puts "--------------------------------"
puts ""
puts "final height"
puts ""
t.height(100)
puts "--------------------------------"
puts ""
puts "pretty print"
puts ""
t.pretty_print