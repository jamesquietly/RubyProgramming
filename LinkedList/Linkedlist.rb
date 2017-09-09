class Node
    attr_accessor :value, :next

    def initialize(value, next_node=nil)
        @value = value
        @next = next_node
    end
end

class LinkedList
    attr_accessor :head
    attr_reader :size


    def initialize
        @head = nil
        @size = 0
    end

    def append(node)
        tail_node = tail()
        if tail_node.nil?
            @head = node
        else
            tail_node.next = node
        end
        @size += 1
    end

    def prepend(node)
        node.next = @head
        @head = node
        @size += 1
    end

    def head=(node)
        self.prepend(node)
    end

    def tail
        current = @head
        unless current.nil?
            until current.next.nil?
                current = current.next
            end
        end
        current
    end

    def at(index)
        if index >= @size
            puts "out of range"
            return nil
        end

        current = @head
        count = 0
        until current.nil?
            if count == index
                return current
            end
            current = current.next
            count += 1
        end
    end

    def pop
        if @size > 0
            current = @head
            until current.next.next.nil?
                current = current.next
            end
            result = current.next
            current.next = nil
            @size -= 1
            result.value
        else
            puts "list is empty"
        end
    end

    def contains?(target)
        result = false
        current = @head
        until current.nil?
            if current.value == target
                return true
            end
            current = current.next
        end
        result
    end

    def find(target)
        current = @head
        index = 0
        until current.nil?
            if current.value == target
                return index
            end
            current = current.next
            index += 1
        end

        nil
    end

    def to_s
        current = @head
        until current.nil?
            print "( #{current.value} ) -> "
            current = current.next
        end
        print "nil"
    end

    def insert_at(index, data)
        if index > -1 && index < @size
            new_node = Node.new(data)
            new_node.next = at(index)
            if index == 0
                @head = new_node
            elsif index > 0
                before = self.at(index - 1)
                before.next = new_node
            end
            @size += 1
        end
    end

    def remove_at(index)
        if index > -1 && index < @size
            if index == 0
                @head = @head.next
            else
                at(index - 1).next = at(index + 1)
            end
            @size -= 1
        end
    end
end


link = LinkedList.new
link.append(Node.new(4, nil))
puts link.to_s
link.prepend(Node.new(5, nil))
puts link.to_s


puts "link size: #{link.size}"

puts "pop: #{link.pop}"

link.append(Node.new(2, nil))
link.append(Node.new(6, nil))
puts link.to_s

puts "contains 7? : #{link.contains?(7)}"
puts "contains 6? : #{link.contains?(6)}"

puts "at 0 : #{link.at(0)}"
puts "at 1 : #{link.at(1)}"
puts "at 2 : #{link.at(2)}"

puts "find 1 : #{link.find(1)}"
puts "find 6 : #{link.find(6)}"

link.insert_at(0, 7)
puts "insert at index 0, value 7 "
puts link.to_s
puts "remove at 0"

link.insert_at(2, 1)
puts "insert at index 2, value 1 "
puts link.to_s
puts "remove at 0"
link.remove_at(0)
puts link.to_s
puts "remove at 1"
link.remove_at(1)
puts link.to_s