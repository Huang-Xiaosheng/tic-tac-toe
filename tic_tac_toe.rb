class Player
  attr_reader :board, :xo, :name

  def initialize(board, xo, name)
    @board = board
    @xo = xo
    @name = name
    board.players << self
  end

  def play
    loop do
      board.show
      print "请#{name}输入位置"
      num = gets.chomp.to_i 
      if num > 0 && num < 10 && board.result[num - 1].nil?
        board.result[num - 1] = xo
        break
      end     
    end
    
  end
end

class Board
  attr_accessor :players, :result

  def initialize
    @players = []
    @result = Array.new(9)
  end

  def show
    puts
    result.each_with_index do |position, index|
      position = position ? position : " "
      if index % 3 == 2
        if index < 6
          print position + "\n------\n"
        else
          print position + "\n"
        end
      else
        print position + "|"
      end
    end
    puts
  end

  def horizontal_same?
    (result[0] && (result[0] == result[1] && result[1] == result[2])) ||
    (result[3] && (result[3] == result[4] && result[4] == result[5])) ||
    (result[6] && (result[6] == result[7] && result[7] == result[8]))
  end

  def vertical_same?
    (result[0] && (result[0] == result[3] && result[3] == result[6])) ||
    (result[1] && (result[1] == result[4] && result[4] == result[7])) ||
    (result[2] && (result[2] == result[5] && result[5] == result[8]))
  end

  def diagonal_same?
    result[4] && 
    ((result[0] == result[4] && result[4] == result[8]) ||
    (result[2] == result[4] && result[4] == result[6]))
  end

  def end?
    horizontal_same? || vertical_same? || diagonal_same?
  end
end

board = Board.new
play1 = Player.new(board, "X", "player1")
play2 = Player.new(board, "O", "player2")
1.upto(9) do |n|
  if n.odd?
    play1.play
  else
    play2.play
  end
  if board.end?
    board.show
    puts "Game Over!"
    break
  end
end
