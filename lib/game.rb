# frozen_string_literal: true

require_relative 'board'
require 'color'
require 'color_conversion'

# Class Game
class Game
  COUNT = 4

  def initialize
    @board = Board.new

    @computer_color_code = generate_random_color(COUNT)
    @guessed_color_code = Array.new(COUNT) { Array.new(COUNT) }
    @computer_guessed_code = @computer_color_code.sample[4]
    @computer = 'O'
    @player = 'X'
    @level = 0 # Initial -1 because increment array
  end

  def generate_random_color(count)
    Array.new(count)
    {
      'red' => '#FF0000',
      'green' => '#008000',
      'blue' => '#0000FF',
      'yellow' => '#FFFF00',
      'black' => '#000000',
      'white' => '#FFFFFF',
      'orange' => '#FFA500',
      'purple' => '#800080'
    }
  end

  def play
    puts @computer_color_code.inspect
    COUNT.times do
      @board.display_board
      color = prompt_color
      puts "Color: #{color.inspect}"

      if get_guess_color(color).last
        puts "#{color} Found"
        puts "Guessed color code placed: #{@guessed_color_code}"
      else
        puts 'Foo'
      end
    end

    @board.display_board
    # puts "Guessed color codes are: #{@guessed_color_code}"
  end

  def prompt_color
    COUNT.times do |i|
      loop do
        puts 'Choose the colors you wants guess:'
        user_input = gets.chomp

        if user_input.is_a?(String) && valid_color_name?(user_input)
          colored = Color::RGB.by_name(user_input).html.upcase
          @guessed_color_code[@level][i] = colored
          add_guess(user_input, @level, i)
          @board.display_board
          break # Break out the inner loop
        else  
          puts "invalid color input #{user_input}"
          # The loop will repeat, allowing user to try again without losing current slot
        end
      end
    end

    @level += 1
    @guessed_color_code
  end

  def valid_color_name?(color_name)
    Color::RGB.by_name(color_name)
    true
  rescue KeyError => e
    puts "Error: #{e.message}"
    false
  end

  def get_guess_color(color)
    @computer_color_code.each do |color_name, color_hex|
      if color_hex == color
        puts "Color-Hex: #{color_hex} | Color-name: #{color_name} | Color: #{color}"
        return [color, true]
      end
    end

    [color, false]
  end

  def add_guess(guessed_color_code, level, column)
    @board.update(guessed_color_code, level, column)
  end
end

Game.new.play
