require 'pry'
class TicTacToe

    attr_accessor :board
    
    def initialize
        @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board()
        puts " 
        #{self.board[0]} | #{self.board[1]} | #{self.board[2]} 
        \n-----------\n 
        #{self.board[3]} | #{self.board[4]} | #{self.board[5]} 
        \n-----------\n 
        #{self.board[6]} | #{self.board[7]} | #{self.board[8]} 
        "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move (player_index, player_token = "X")
        self.board[player_index] = player_token
    end

    def position_taken?(board_index)
        self.board[board_index] != " "
    end

    def valid_move?(board_index)
        !position_taken?(board_index) && board_index.between?(0,8)
    end

    def turn_count
        self.board.length - self.board.count(" ")
    end
    
    def current_player
        if turn_count%2 == 0
            return "X"
        else
            return "O"
        end
    end

    def turn
        puts "What position do you want to place your token (1 = upperleft corner 9 = lowerright corner)"
        player_move = gets.strip
        player_move_indexed = input_to_index(player_move)
        # binding.pry
        if valid_move?(player_move_indexed)
            move(player_move_indexed, current_player)
        else
            puts "Move is invalid please chose again"
            turn
        end
        display_board        
    end

    def won?
        winning_combo = []
        x_indexes = self.board.each_index.select{|i| self.board[i] == "X"}
        o_indexes = self.board.each_index.select{|i| self.board[i] == "O"}

        WIN_COMBINATIONS.each do |combo|
            if (x_indexes & combo).length == 3 || (o_indexes & combo).length == 3
                winning_combo = combo
            end
        end
        winning_combo.empty? ? false : winning_combo
    end

    def full?
        !self.board.include?(" ")
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || self.draw?
    end

    def winner
        won? ? self.board[won?[0]] : nil
    end

    def play
        until over? do
            turn
        end

        if self.draw?
            puts "Cat\'s Game!"
        elsif won?
            puts "Congratulations #{self.winner}!"
        end
        
    end
end

