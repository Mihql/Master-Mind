# frozen_string_literal: true

# main.rb
require 'yaml'

config = YAML.load_file('./lib/config.yml')
require_relative './module'
require_relative './crank'
require_relative './lib/game'
require_relative './lib/api'
require_relative './lib/board'

# Initialize Crank Board and Game instances
board = Board.new
game = Game.new
gameservice = GameService.new(game, config['game'], config['api'])
Crank.new(game)

# Initialize API with Board and Game
api = API.new(board, game, config['game'])

# Set API in Game after both have been created
game.set_api(api, board)
gameservice.set_api(api, board)


# gameService.display_info
# gameService.display_feedback('blue', 33)

# puts api.valid_color_name?("blue")      # Example call to API method
# puts api.color_in_computer_code?("red") # Example checking if color is in computer's code
# api.display_feedback("blue")            # Display feedback for color guess
# api.add_guess_to_board("blue", 2, 1)    # Add a guess to the board

code = api.new_computer_guess_code

color_index_found = []
color_arr = []

config['game']['max_guess'].times do |level|
  config['game']['max_guess'].times do |index|
    api.send_client_message(:normal)
    color, color_arr = api.ask_user_prompt_color(color_arr)
    puts api.check_color_at_index(color, code, index)
    game.process_display(color, level, index)
  end
  message = api.check_color_arr_at_combination(color_arr, code)
  puts message
  color_index_found = []
  color_arr = []
  game.player_guess = 0
end
