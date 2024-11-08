# frozen_string_literal: true

require 'color'

# File Loader
require_relative 'color_loader'

require_relative './api'

# Class Game: Manages the gameplay, intractions, logic, display
class Game
  attr_accessor :computer_color_guessed_code, :player_guessed_right, :user_input

  def initialize
    @color_loader = ColorLoader.new # Load colors from YAML
    @computer_color_guessed_code = ["red", "blue", "green", "black", "white"]
    @player_guessed_right = 69
  end

  # Setter to inject API after initialization
  def set_api(api, board)
    @api = api
    @board = board
  end

  ## Gutter Engine Process, Evaluate

  def process_guess(color_get, level, index)
    @api.add_guess_to_board(color_get, level, index)
  end

  def evaluate_guess(color)
    result = @api.color_in_computer_code?(@user_input)
    puts result ? "#{result} - correct" : "No match for #{color}"
    @player_guessed_right += 1 if result
    @api.display_feedback(@user_input)
  end

  def each_level_color_prompted_evaluate_color(color_arr_main)
    color_arr = []
    computer_color_guessed_code.each do |value|
      color_arr << value
    end

    result = @api.check_if_colorSet_in_combination(color_arr, color_arr_main)
    puts "RESULT-check_if_color_in_computer_code_color::: #{result}"
    puts "COLOR CLEARR UOUT__________: #{color_arr_main}"
    result
  end

  def process_prompt
    5.times do
      loop do
        prompted_color = @api.ask_user_prompt_color
        if @api.valid_input?(prompted_color)
          return prompted_color
        else
          puts "Enter correct color format"
        end
      end
    end
    nil
  end
  
end
