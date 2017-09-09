
class Knight
    attr_accessor :location, :moves, :previous

    def initialize(loc, prev=nil)
        @location = loc
        possible_moves
        @previous = prev
    end

    def possible_moves
        p_moves = [[@location[0] + 2, @location[1] + 1],
                 [@location[0] + 2, @location[1] - 1],
                 [@location[0] - 2, @location[1] + 1],
                 [@location[0] - 2, @location[1] - 1],
                 [@location[0] + 1, @location[1] + 2],
                 [@location[0] + 1, @location[1] - 2],
                 [@location[0] - 1, @location[1] + 2],
                 [@location[0] - 1, @location[1] - 2]]
        @moves = p_moves.select { |loc| loc[0] >= 0 && loc[0] <= 7 && loc[1] >= 0 && loc[1] <= 7}
    end

end


def knight_moves(start, destination)
    queue = []
    checked = []
    current = Knight.new(start)
    until current.location == destination
        current.moves.each do |possible_loc|
            if !checked.include?(possible_loc)
                queue.push(Knight.new(possible_loc, current))
                checked.push(possible_loc)
            end
        end
        current = queue.shift
    end
    route = []
    route.push(current.location)
    until current.previous.nil?
        route.push(current.previous.location)
        current = current.previous
    end

    puts "You made it in #{route.length - 1} moves! Here's your path:"
    route.reverse.each do |path|
        print path
        print "\n"
    end
end

knight_moves([0, 0], [1,2])
knight_moves([0, 0], [3,3])
knight_moves([3,3],[0,0])
knight_moves([3,3], [4,3])