require 'byebug'
require_relative 'tree_nodes.rb'

class KnightPathFinder 

    attr_accessor :OFFSETS, :root_node, :considered_positions

    @@OFFSETS = [[1, -2], [1, 2], [2, -1], [2, 1], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]

    def self.valid_moves(pos)
        positions = @@OFFSETS.map {|offset| [pos[0] + offset[0], pos[1] + offset[1]]}
        return positions.select {|position| 0 <= position[0] && position[0] < 8 && 0 <= position[1] && position[1] < 8}
    end

    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [starting_pos]
    end

    def build_move_tree
        queue = [@root_node]
        while queue.length > 0  
            node = queue.shift # not returning anything 
            new_move_positions(node.value).each do |pos|
                pos_node = PolyTreeNode.new(pos)
                node.add_child(pos_node)
                queue.push(pos_node)
            end 
        end
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos).reject {|move| @considered_positions.include?(move)}
        @considered_positions += moves
        return moves 
    end

    # find shortest path from root node to end node 
    def find_path(end_pos) # parameter is value of the end node 
        # all_paths = Set.new
        build_move_tree
        end_node = @root_node.dfs(end_pos) # gives back end node itself
        path = trace_path_back(end_node)
        # all_paths.add(path)
        return path

    end 

    # just provides the path from root node to end node, not necessarily the shortest 

    def trace_path_back(node, path = []) # pass in the end node
        path << node.value
        return path.reverse if node == @root_node # return our path if we are at root node, because it has no parents
        trace_path_back(node.parent, path)
    end
end

