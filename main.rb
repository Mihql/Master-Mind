# frozen_string_literal: true

# main.rb
require_relative './crank'
require_relative './lib/game'
require_relative './lib/api'
require_relative './lib/board'

# Initialize Crank Board and Game instances
board = Board.new
game = Game.new

crank = Crank.new(game)

# Initialize API with Board and Game
api = API.new(board, game)

# Set API in Game after both have been created
game.set_api(api, board)

crank.play
# puts api.valid_color_name?("blue")      # Example call to API method
# puts api.color_in_computer_code?("red") # Example checking if color is in computer's code
# api.display_feedback("blue")            # Display feedback for color guess
# api.add_guess_to_board("blue", 2, 1)    # Add a guess to the board
# board.display_board
