require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_accessor :board, :mark, :node, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos = board, next_mover_mark, prev_move_pos
  end

  def find_next_mover_mark
    if self.next_mover_mark == :x  
      return :o
    else
      return :x
    end
  end

  def losing_node?(evaluator)
    return false if board.tied?
    if board.over? 
      return board.winner != evaluator 
    end
    if next_mover_mark == evaluator # this means it is opponent's turn 
      return self.children.all? {|child| child.losing_node?(evaluator)}
    else # it is our turn 
      return self.children.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if board.over? 
      return board.winner == evaluator
    end
    if mark = evaluator 
      self.children.any? {|child| child.winning_node?(evaluator)}
    else
      self.children.all? {|child|child.winning_node?(evaluator)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        if board.empty?(pos)
          new_board = board.dup
          new_board[pos] = self.next_mover_mark
          
          moves << TicTacToeNode.new(new_board, self.find_next_mover_mark, pos)
        end
      end
    end
    return moves
  end
end
