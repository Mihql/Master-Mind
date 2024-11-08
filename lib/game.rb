# frozen_string_literal: true

require 'color'

# File Loader
require_relative 'color_loader'

require_relative './api'

# Class Game: Manages the gameplay, intractions, logic, display
class Game
  attr_accessor :computer_guessed_code, :player_guessed_right, :user_input

  COUNT = 4
  COLOR_INFO = Array.new(COUNT)

  def initialize
    @color_loader = ColorLoader.new # Load colors from YAML

    @computer_color_code = @color_loader.color_info
    @computer_guessed_code = @computer_color_code['colors'].keys.sample(4)

    @user_input = ''
    @level = 0
    @interface_iterate = 0
    @player_guessed_right = 0

    @guessed_color_code = Array.new(COUNT) { Array.new(COUNT) }
  end

  # Setter to inject API after initialization
  def set_api(api, board)
    @api = api
    @board = board
  end

  ## Interface
  def prompt_for_guess
    5.times do |i|
      @interface_iterate = i
      loop do
        puts "Choose the colors you want to guess: Game colors #{@computer_color_code}"
        @user_input = gets.chomp

        break process_guess(@user_input, @interface_iterate) if @api.valid_input?(@user_input)

        puts "Invalid color input: #{@user_input}"
      end
    end
    @level += 1
  end

  private

  ## Gutter Engine Process Evaluate

  def process_guess(color, index)
    puts "#{@user_input} USER"
    @guessed_color_code[@level][index] = color # "color_name"
    @api.add_guess_to_board(@user_input, @level, index)
    evaluate_guess(@user_input)
  end

  def evaluate_guess(color)
    result = @api.color_in_computer_code?(@user_input)
    puts result ? "#{result} - correct" : "No match for #{color}"
    @player_guessed_right += 1 if result
    @api.display_feedback(@user_input)
  end
end
