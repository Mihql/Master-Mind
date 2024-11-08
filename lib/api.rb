# frozen_string_literal: true

require 'color'

# Class API: Valid check, Include check, Display Interface
class API
  def initialize(board, game)
    @board = board
    @game = game
  end

  ## API Valid Include check
  def valid_color_name?(color_name)
    Color::RGB.by_name(color_name)
    true
  rescue KeyError => e
    puts "Error: #{e.message}"
    false
  end

  # #Include check bool result
  def color_in_computer_code?(color)
    @game.computer_guessed_code.include?(color)
  end
  ####

  def valid_input?(user_input)
    user_input.is_a?(String) && valid_color_name?(user_input)
  end

  ## Display
  def display_feedback(color)
    puts "You guessed #{color}: #{@game.player_guessed_right} correct out of / 5"
  end

  def add_guess_to_board(color, level, row)
    @board.update(color, level, row)
    @board.display_board
  end
  #####
end
