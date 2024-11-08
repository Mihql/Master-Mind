# frozen_string_literal: true

require 'color'

# Class API: Valid check, Include check, Display Interface
class API
  def initialize(board, game, config)
    @board = board
    @game = game
    @feedback_message = config['feedback_message']
  end

  ## API Valid Include check
  def valid_color_name?(color_name)
    Color::RGB.by_name(color_name)
    true
  rescue KeyError => e
    puts "Error: #{e.message}"
    false
  end

  def ask_user_prompt_color
    puts "Enter you desire Color"
    user_prompted_color = gets.chomp
  end

  def check_if_indexColor_in_combination(color, color_arr)
  end

  def check_if_colorSet_in_combination(color_arr, color_arr_main)
    puts "COLOR_ARR__________: #{color_arr_main}"
    if @game.computer_color_guessed_code == color_arr_main || @game.computer_color_guessed_code.sort == color_arr_main.sort
      # color_arr_main.delete(color)
      return "Congrates Color-Set #{color_arr_main} found on the winning combination, Good now move on next level of #{color_arr}"
    else
      return "Here is the Feedback Attemp CHEAT: #{color_arr_main} not found. Here is the winning color combination #{color_arr}"
    end
  end
  
  def color_in_computer_code?(color)
    @game.computer_color_guessed_code.include?(color)
  end

  def valid_input?(user_input)
    user_input.is_a?(String) && valid_color_name?(user_input)
  end

  ## Display
  # def display_feedback(color)
  #   puts "You guessed #{color}: #{@game.player_guessed_right} correct out of / 5"
  # end

  def add_guess_to_board(color, level, row)
    @board.update(color, level, row)
  end

  def display_board
    @board.display_board
  end

end
