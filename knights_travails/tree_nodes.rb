class PolyTreeNode
    attr_reader :parent, :value, :children
    def initialize(value)
        @parent = nil 
        @value = value
        @children = [] # adds INSTANCES of children
    end

    # def inspect
    #     @value.inspect
    # end

    def parent=(parent)
        if parent == nil
            @parent.children.delete(self)
            @parent = parent
            return nil
        end
        @parent.children.delete(self) if self.parent != nil # reassigning
        parent.children << self unless parent.children.include?(self)
        @parent = parent
    end

    def remove_child(child_node)
        child_node.parent = nil
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def dfs(target_value)
        return nil if self == nil 
        return self if self.value == target_value 
        @children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result == nil
        end
        return nil
    end

    def bfs(target_value)
        queue = [self]
        while queue.length > 0 
            node = queue.shift
            return node if node.value == target_value
            node.children.each {|child| queue.push(child)}
        end
        return nil 
    end
end