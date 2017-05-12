class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # Defines a constant WIN_COMBINATIONS with arrays for each win combination
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  # Takes the user_input (which is a string), converts it to an Integer, and subtracts 1
  def input_to_index(user_input)
    user_input.to_i - 1
  end

  # Takes three arguments: board, position, and player token
  def move(index, token)
    @board[index] = token
  end

  # Returns true/false based on position in board
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  # Accepts a board and an index to check and returns true if the move is valid and false or nil if not
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  # Makes valid moves
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  # Counts occupied positions
  def turn_count
    counter = 0
    @board.each do |squares|
      if squares != " " && squares != ""
        counter += 1
      end
    end
    counter
  end

  # Returns the correct player's turn "X" or "O"
  def current_player
    turn_count.even? ? "X" : "O"
  end

  # Accept a board as an argument and return false/nil if there is
  # no win combination present in the board and return the winning
  # combination indexes as an array if there is a win
  def won?
    empty_board = @board.all? do |element|
      element.nil? || element == " "
    end
    if empty_board
      return false
    end
    # For each win_combination in WIN_COMBINATIONS
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    WIN_COMBINATIONS.each do |win_combination|
      # grab each index from the win_combination that composes a win.
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      # puts "#{win_combination}"
      if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
         (position_1 == "O" && position_2 == "O" && position_3 == "O")
         return win_combination # return the win_combination indexes that won.
      else
         false
      end
    end

    return false
  end

  # Return true if every element in the board contains either an "X" or an "O"
  def full?
    @board.all? do |element|
      element == "X" || element == "O"
    end
  end

  # Returns true if the board has not been won and is full
  # and false if the board is not won and the board is not full,
  # and false if the board is won
  def draw?
    if won? || !full?
      false
    else
      true
    end
  end

  # Returns true if the board has been won, is a draw, or is full
  def over?
    if won? || full? || draw?
      true
    else
      false
    end
  end

  # Return the token, "X" or "O" that has won the game given a winning board
  def winner
    if winning_combination = won?
      @board[winning_combination[0]]
    end
  end

# Define your play method below
  def play
    while !over?
      turn
    end
    if token = winner
      puts "Congratulations #{token}!"
    else
      puts "Cat's Game!"
    end
  end
  
end
