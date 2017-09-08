class Node
    attr_accessor :value, :left, :right

    def initialize(value, left=nil, right=nil)
        @value = value
        @left = left
        @right = right
    end
end

#build tree from sorted array
def build_tree(arr)
    if arr.empty?
        return nil
    end

    mid = arr.length/2
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid+1)..-1])

    root
end

# helper for build_tree_unsorted
def insert_tree(value, tree)
    if tree.nil?
        return Node.new(value)
    end

    #if current value < parent value, insert to left
    tree.left = insert_tree(value, tree.left) if value < tree.value
    #else insert to right
    tree.right = insert_tree(value, tree.right) if value >= tree.value

    tree
end

#builds a tree from unsorted array
def build_tree_unsorted(arr)
    root = nil
    arr.each do |item|
        root = insert_tree(item, root)
    end

    root
end

def in_order(node)
    if node == nil
        return ""
    end
    in_order(node.left)
    puts node.value
    in_order(node.right)

end

def breadth_first_search(target, tree)
    queue = []
    queue.push(tree) if tree
    until queue.empty? do
        current = queue.shift
        if current.value == target
            return current
        end

        if !current.left.nil?
            queue.push(current.left)
        end

        if !current.right.nil?
            queue.push(current.right)
        end
    end

    nil
end

def depth_first_search(target, tree)
    stack = []
    stack.push(tree) if tree
    until stack.empty? do
        current = stack.pop()
        if current.value == target
            return current
        end

        if !current.left.nil?
            stack.push(current.left)
        end

        if !current.right.nil?
            stack.push(current.right)
        end

    end

    nil
end

#recursive dfs
def dfs_rec(target, tree)
    if tree.nil?
        return nil
    end

    if tree.value == target
        return tree
    end

    dfs_rec(target, tree.left) unless tree.left.nil?
    dfs_rec(target, tree.right) unless tree.right.nil?
    
end

#tests
=begin
tree1 = build_tree([1, 2, 3, 4])
root = build_tree_unsorted([1, 5, 3, 9, 3, 2, 3])

puts breadth_first_search(4, tree1).value
puts breadth_first_search(9, root).value
puts depth_first_search(5, root).value
puts dfs_rec(9, root).value
=end