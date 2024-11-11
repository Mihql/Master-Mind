# frozen_string_literal: true

require 'color'

# File Loader
require_relative 'color_loader'
require_relative './enum_module'

require_relative './api'

# Class Game: Manages the gameplay, intractions, logic, display
class Game
  include PlayerRole
  attr_accessor :computer_color_guess, :player_guessed_each_right, :player_guessed_each_with_index_right,
                :player_guessed_level_right, :user_input, :player_guess

  def initialize
    @color_loader = ColorLoader.new # Load colors from YAML
    @computer_color_guess = %w[red blue green black white purple]
    @player_guessed_each_with_index_right = 0
    @player_guessed_each_right = 0
    @player_guessed_level_right = 0
    @player_guess = 0
  end

  # Setter to inject API after initialization
  def set_api(api, board)
    @api = api
    @board = board
  end

  ## Service Layer / process, evaluate

  def process_display(color, level, index)
    @api.add_guess_to_board(color, level, index)
    @board.display_board
  end

  def process_player_role(code)
    puts "Enter desire role:: #{PlayerRole::PLAYER} : #{PlayerRole::PLAY_MAKER}"
    role = @api.return_player_role
    code = role == PlayerRole::PLAYER ? @api.new_computer_guess_code : @api.choose_color_code 
  end

  def evaluate_guess(color, color_arr, index, code)  
    color = @api.validate_color(color)
    message, state = @api.check_color_at_index(color, code, index)
    puts message
    color_arr << color 
    return color, color_arr
  end
end
