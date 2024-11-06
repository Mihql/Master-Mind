# frozen_string_literal: true

require_relative 'board'
require_relative 'color_loader'
require 'color'

# Class Game: Manages the gameplay, intractions, and logic
class Game
  COUNT = 4

  COLOR_INFO = Array.new(COUNT)

  def initialize
    @board = Board.new
    @color_loader = ColorLoader.new # Load color form yml
    @computer_color_code = load_color
    @computer_guessed_code = @computer_color_code['colors'].keys.sample(4)
    @level = 0
    @player_guessed_right = 0
    @guessed_color_code = Array.new(COUNT) { Array.new(COUNT) }
  end

  def play
    COUNT.times do
      @board.display_board
      prompt_for_guess
    end

    puts "Guessed color codes are: #{@guessed_color_code}"
  end

  private

  def load_color
    puts @color_loader.color_info
    @color_loader.color_info
  end

  def prompt_for_guess
    COUNT.times do |i|
      loop do
        puts "Choose the colors you wants guess: Game colors #{@computer_color_code}"
        user_input = gets.chomp
        break process_guess(user_input, i) if valid_input?(user_input)

        puts "invalid color input #{user_input}"
      end
    end
    @level += 1
  end

  def valid_input?(user_input)
    user_input.is_a?(String) && valid_color_name?(user_input)
  end

  def valid_color_name?(color_name)
    Color::RGB.by_name(color_name)
    true
  rescue KeyError => e
    puts "Error: #{e.message}"
    false
  end

  def process_guess(color, index)
    @guessed_color_code[@level][index] = color # "color_name"
    evaluate_guess(color) # evaluvate first then add to board
    add_guess_to_board(color, @level, index)
  end

  def evaluate_guess(color)
    result = color_in_computer_code?(color)
    puts result ? "#{result} - correct" : "No match for #{color}"
    @player_guessed_right += 1 if result
    display_feedback(color, @player_guessed_right)
  end

  def color_in_computer_code?(color)
    @computer_guessed_code.include?(color)
  end

  def display_feedback(color, guessed_right_count)
    puts "You guessed #{color}: #{guessed_right_count} correct out of / #{COUNT}"
  end

  def add_guess_to_board(color, level, row)
    @board.update(color, level, row)
  end
end

Game.new.play
