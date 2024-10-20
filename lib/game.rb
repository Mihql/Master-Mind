# frozen_string_literal: true

require_relative 'board'
require 'color'
require 'color_conversion'

# Class Game
class Game
  COUNT = 5

  def initialize
    @board = Board.new

    @computer_color_code = generate_random_color(COUNT)
    @gussed_color_code = []
    puts @computer_color_code.inspect
    @computer = 'O'
    @player = 'X'
  end

  def generate_random_color(count)
    Array.new(count)
    {
      'red' => '#FF0000',
      'green' => '#008000',
      'blue' => '#0000FF',
      'yellow' => '#FFFF00',
      'black' => '#000000',
      'white' => '#FFFFFF'
    }
  end

  def play
    COUNT.times do
      # @board.display_board
      color = prompt_color.upcase
      puts "Color: #{color}"

      if get_handle_guess(color).last
        puts "#{color} Found"
        @gussed_color_code << color
        puts "Guessed color code placed: #{@gussed_color_code}"
      else
        puts 'Foo'
      end
    end

    puts "Guessed color codes are: #{@gussed_color_code}"
  end

  def prompt_color
    loop do
      puts 'Choose the colors you wants guess:'
      user_input = gets.chomp

      if user_input.is_a?(String) && valid_color_name?(user_input)
        color = Color::RGB.by_name(user_input).html
        return color # Convert color name to hex
      else
        puts "invalid color input #{user_input}"
      end
    end
  end

  def valid_color_name?(color_name)
    Color::RGB.by_name(color_name)
    true
  rescue KeyError => e
    puts "Error: #{e.message}"
    false
  end

  def get_handle_guess(color)
    @computer_color_code.each do |color_name, color_hex|
      if color_hex == color
        puts "Color-Hex: #{color_hex} | Color-name: #{color_name} | Color: #{color}"
        return [color, true]
      end
    end

    [color, false]
  end
end

Game.new.play
