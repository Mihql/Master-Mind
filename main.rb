# frozen_string_literal: true

# main.rb
require 'yaml'

config = YAML.load_file('./lib/config.yml')
require_relative './module.rb'
require_relative './crank'
require_relative './lib/game'
require_relative './lib/api'
require_relative './lib/board'

# Initialize Crank Board and Game instances
board = Board.new
game = Game.new
gameService = GameService.new(game, board, config['game'],  config['api'])
crank = Crank.new(game)

# Initialize API with Board and Game
api = API.new(board, game, config['api'])

# Set API in Game after both have been created
game.set_api(api, board)
gameService.set_api(api, board)


gameService.play_turn("white")
# gameService.display_info
# gameService.display_feedback('blue', 33)

# 5.times do |i|
#   game.process_guess("white", i)
# end

# puts api.valid_color_name?("blue")      # Example call to API method
# puts api.color_in_computer_code?("red") # Example checking if color is in computer's code
# api.display_feedback("blue")            # Display feedback for color guess
# api.add_guess_to_board("blue", 2, 1)    # Add a guess to the board
board.display_board
