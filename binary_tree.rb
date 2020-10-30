class Node
    attr_accessor :data, :left_child, :right_child

    def initialize(value)
        @data = value
        @left_child = nil
        @right_child = nil
    end
end

class Tree
    attr_accessor :root

    def initialize(array)
        @root = build_tree(false, array, 0, array.length - 1)
    end

    def order_array(array)
        new_array = []

        if array.length < 2
            return array
        elsif array.length == 2
            if array[0] > array[1]
                new_array = [array[1], array[0]]
            else
                new_array = [array[0], array[1]]
            end

            return new_array
        else
            sorted_left = order_array(array.slice(0, array.length / 2)).to_a
            sorted_right = order_array(array.slice(array.length / 2..-1)).to_a
            finished_sorted_array = merge_new_array(sorted_left, sorted_right)
            return finished_sorted_array
        end
    end

    def merge_new_array(left, right)
        return right if left.empty?
        return left if right.empty?
            
        if left[0] < right[0]
            return [left[0]] + merge_new_array(left[1..left.length], right)
        else
            return [right[0]] + merge_new_array(left, right[1..right.length])
        end
    end

    def remove_doubles(array)
        new_array = []
        
        array.each do |item|
            if !new_array.include?(item)
                new_array.push(item)
            end
        end

        return new_array
    end

    def build_tree(ordered, array, start = 0, last = array.length - 1)
        if start > last
            return nil 
        end

        if !ordered
            ordered_array = order_array(remove_doubles(array))
            mid = (start + ordered_array.length - 1) / 2
            root = Node.new(ordered_array[mid])
            root.left_child = build_tree(true, ordered_array, start, mid - 1)
            root.right_child = build_tree(true, ordered_array, mid + 1, ordered_array.length - 1)
            ordered = true

            return root
        else
            mid = (start + last) / 2
            root = Node.new(array[mid])
            root.left_child = build_tree(true, array, start, mid - 1)
            root.right_child = build_tree(true, array, mid + 1, last)

            return root
        end
    end

    def insert(n, node = @root)
        if n == node.data
            puts n.to_s + " already exists within the tree"
            puts ""
            return node
        elsif node == nil
            return node
        elsif n < node.data
            if node.left_child == nil
                puts "added " + n.to_s + " node to left of " + node.data.to_s
                puts ""
                node.left_child = Node.new(n)
            else
                insert(n, node.left_child)
            end
        elsif n > node.data
            if node.right_child == nil
                puts "added " + n.to_s + " node to right of " + node.data.to_s
                puts ""
                node.right_child = Node.new(n)
            else
                insert(n, node.right_child)
            end
        end

        return node
    end

    def inorder_successor(node)
        if node.left_child == nil
            return node
        else
            return inorder_successor(node.left_child)
        end
    end

    def delete(n, node = @root)
        if node == nil
            return node
        elsif n > node.data
            node.right_child = delete(n, node.right_child)
        elsif n < node.data
            node.left_child = delete(n, node.left_child)
        else
            puts "deleting node " + node.data.to_s
            puts ""

            if node.left_child == nil && node.right_child == nil
                node = nil
            elsif node.right_child == nil
                temp = node.left_child
                node.left_child = nil
                node = temp
            elsif node.left_child == nil
                temp = inorder_successor(node.right_child)
                node.data = temp.data
                node.right_child = temp.right_child
                delete(temp.data, node.right_child)
            else
                temp = inorder_successor(node.right_child)
                node.data = temp.data
                delete(temp.data, node.right_child)

                if node.data == node.right_child.data
                    node.right_child = nil
                end
            end
        end

        return node
    end

    def inorder(arr, node = @root)
        return node if node == nil

        inorder(arr, node.left_child)
        arr.push(node.data)
        inorder(arr, node.right_child)

        if node == @root
            puts "inorder " + arr.to_s
            puts ""
        end

        return arr
    end

    def preorder(arr, node = @root)
        return node if node == nil

        arr.push(node.data)
        preorder(arr, node.left_child)
        preorder(arr, node.right_child)

        if node == @root
            puts "preorder " + arr.to_s
            puts ""
        end

        return arr
    end

    def postorder(arr, node = @root)
        return node if node == nil

        postorder(arr, node.left_child)
        postorder(arr, node.right_child)
        arr.push(node.data)

        if node == @root
            puts "postorder " + arr.to_s
            puts ""
        end
        return arr
    end

    def find(n, node = @root)
        if node == nil
            return node
        elsif n < node.data
            temp = find(n, node.left_child)
            return temp
        elsif n > node.data
            temp = find(n, node.right_child)
            return temp
        else
            puts "found node " + node.to_s
            puts "node data " + node.data.to_s
            puts "node left child " + node.left_child.data.to_s if node.left_child != nil
            puts "node right child " + node.right_child.data.to_s if node.right_child != nil
            puts ""
            return node
        end
    end

    def level_order(array, node = @root)
        queue = Queue.new
        new_array = array
        current_node = node
        queue.push(node)

        if node == nil
            return node
        else
            until queue.empty?
                current_node = queue.pop
                
                if current_node.left_child != nil
                    queue.push(current_node.left_child)
                end

                if current_node.right_child != nil
                    queue.push(current_node.right_child)
                end

                new_array.push(current_node.data)
            end

            puts "level order " + new_array.to_s
            puts ""
            return new_array
        end
    end

    def height(n, h = 0, node = @root)
        return h - 1 if node == nil

        if n == node.data
            puts "height " + h.to_s
            puts ""
        else
            height(n, h + 1, node.left_child)
            height(n, h + 1, node.right_child)
        end

        return h
    end

    def depth(node = @root)
        return 0 if node == nil

        l_depth = depth(node.left_child)
        r_depth = depth(node.right_child)

        if node == @root
            puts "l depth " + l_depth.to_s
            puts "r depth " + r_depth.to_s
            puts ""
        end

        if l_depth > r_depth
            
            return (l_depth + 1)
        else
            
            return (r_depth + 1)
        end

        
    end

    def balanced?(node = @root)
        return 0 if node == nil

        l_depth = depth(node.left_child)
        r_depth = depth(node.right_child)

        if (l_depth - r_depth).abs > 1
            puts "tree unbalanced at node " + node.data.to_s
            puts ""
            return "unbalanced"
        else
            puts "tree balanced at node " + node.data.to_s
            puts ""
            return "balanced"
        end
    end

    def rebalance(node = @root)
        level_order_array = level_order([])

        new_tree = build_tree(false, level_order_array)
        
        return new_tree
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
      end
end