# frozen_string_literal: true

require 'color'

# File Loader
require_relative 'color_loader'

require_relative './api'

# Class Game: Manages the gameplay, intractions, logic, display
class Game
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

  ## Gutter Engine Process, Evaluate

  def process_display(color, level, index)
    @api.add_guess_to_board(color, level, index)
    @board.display_board
  end

  def evaluate_guess; end
end
